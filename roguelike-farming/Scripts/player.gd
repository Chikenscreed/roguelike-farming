class_name Player
extends CharacterBody2D


@export var speed = 300.0
@export var health = 150.0
@export var dash_duration := 0.5
@export var dash_speed_multi := 2.5
@export var dash_cooldown := 0.5

@onready var health_component: HealthComponent = $HealthComponent
@onready var basic_attack: BasicAttack = $Basic_attack

@onready var dash_cooldown_timer: Timer = $dash_cooldown_timer
@onready var dash_timer: Timer = $dash_timer
@onready var visuals: Node2D = $Skeleton
@onready var collision: CollisionShape2D = $AreaCollision

@onready var health_bar: HealthBar = $HealthBar
@onready var hit_flash_player: AnimationPlayer = $Skeleton/HitFlashPlayer
@onready var animation_tree: AnimationTree = $Animation/AnimationTree

var move_dir: Vector2
var is_dashing := false
var is_attacking := false

var knockback = Vector2.ZERO
var knockback_timer: float = 0.0

signal action(position: Vector2)

func _physics_process(_delta: float) -> void:
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= _delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	else:
		if not is_dashing:
			move_dir = Input.get_vector("left", "right", "up", "down")
			
		if is_dashing:
			velocity = move_dir * speed * dash_speed_multi
		else:
			velocity = move_dir * speed
	animate()
	move_and_slide()
	basic_attack.global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("dash") and can_dash():
		dash()
	
func _input(event):
	if event.is_action_pressed("attack"):
		basic_attack.attack()
	if Input.is_action_just_pressed("action"):
		action.emit(global_position)

func _is_dead() -> void:
	queue_free()
	
func can_dash() -> bool:
	return not is_dashing and dash_cooldown_timer.is_stopped()
	

func _ready() -> void:
	dash_timer.wait_time = dash_duration
	dash_cooldown_timer.wait_time = dash_cooldown
	health_component.max_health = health
	set_character_sprites()

func apply_knockback(damage_position: Vector2) -> void:
	var force = 150
	knockback = (global_position - damage_position).normalized() * force
	knockback_timer = 0.7
	
func get_facing_direction() -> Vector2:
	if move_dir != Vector2.ZERO:
		return move_dir
	else:
		if visuals.scale.x == 1:
			return Vector2.RIGHT
		else:
			return Vector2.LEFT

func animate() -> void:
	if move_dir:
		print(round(move_dir.x))
		print(round(move_dir.y))
		var animation_direction = Vector2(round(move_dir.x),round(move_dir.y))
		animation_tree.set("parameters/MoveStateMachine/walk/blend_position", animation_direction)
		animation_tree.set("parameters/MoveStateMachine/dash/blend_position", animation_direction)
		
	else: 	
		animation_tree.set("parameters/MoveStateMachine/walk/blend_position", Vector2.ZERO)
	

func set_character_sprites() -> void:
	$Skeleton/Body.texture = CharacterAppearance.body_collection.get(CharacterAppearance.selected_body)
	$Skeleton/Chest.texture = CharacterAppearance.chest_collection.get(CharacterAppearance.selected_chest)
	$Skeleton/Hair.texture = CharacterAppearance.hair_collection.get(CharacterAppearance.selected_hair)
	$Skeleton/Legs.texture = CharacterAppearance.legs_collection.get(CharacterAppearance.selected_legs)
	$Skeleton/Hands.texture = CharacterAppearance.hands_collection.get(CharacterAppearance.selected_hands)
	$Skeleton/Feet.texture = CharacterAppearance.feet_collection.get(CharacterAppearance.selected_feet)
	$Skeleton/Accessory.texture = CharacterAppearance.accessory_collection.get(CharacterAppearance.selected_accessory)

func dash() -> void:
	if not dash_cooldown_timer.is_stopped():
		return
	is_dashing = true
	animation_tree["parameters/MoveStateMachine/conditions/is_dashing"] = true

	dash_timer.start()
	visuals.modulate.a = 0.5
	collision.set_deferred("disabled", true)

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)


func _on_dash_timer_timeout() -> void:
	is_dashing = false
	animation_tree["parameters/MoveStateMachine/conditions/is_dashing"] = false
	
	visuals.modulate.a = 1.0
	move_dir = Vector2.ZERO
	collision.set_deferred("disabled", false)
	dash_cooldown_timer.start()


func _on_dash_cooldown_timer_timeout() -> void:
	pass # Replace with function body.


func _on_health_component_damage_taken(damage_position: Vector2) -> void:
	apply_knockback(damage_position)
	hit_flash_player.play("hit_flash")
	

func _on_health_component_health_changed(current: float, max: float) -> void:
	if health_bar:
		health_bar.update_health_bar(current, max)
