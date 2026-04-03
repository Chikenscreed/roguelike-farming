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
@onready var hurtbox_collision: CollisionShape2D = $HurtboxComponent/CollisionShape2D

@onready var health_bar: HealthBar = $HealthBar
@onready var hit_flash_player: AnimationPlayer = $Skeleton/HitFlashPlayer
@onready var animation_tree: AnimationTree = $Animation/AnimationTree

@onready var move_state_machine = $Animation/AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var tool_state_machine = $Animation/AnimationTree.get("parameters/ToolStateMachine/playback")

var current_tool = Enum.Tool.HOE

var move_dir:= Vector2.ZERO
var last_dir: Vector2
var can_move:= true
var is_dashing := false
var is_attacking := false

var knockback_distance := 200
var knockback_direction : Vector2

signal action(pos: Vector2)
signal tool_used(tool: Enum.Tool, pos: Vector2)

func _physics_process(_delta: float) -> void:
	if !can_move:
		return
	if move_dir:
		last_dir = move_dir
	if not is_dashing:
		move_dir = Input.get_vector("left", "right", "up", "down")
	if is_dashing:
		velocity = move_dir * speed * dash_speed_multi
	else:
		velocity = move_dir * speed + knockback_direction
	animate()
	if can_move:
		move_and_slide()
	basic_attack.global_position = global_position + last_dir * 15
	if Input.is_action_just_pressed("dash") and can_dash():
		dash()
	
func _input(event):
	if event.is_action_pressed("attack"):
		basic_attack.attack(global_position)
		tool_state_machine.travel("Sword")
		$Animation/AnimationTree.set("parameters/ToolOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	if Input.is_action_just_pressed("action"):
		action.emit(global_position)
	if Input.is_action_just_pressed("use_tool"):
		tool_state_machine.travel("Hoe")
		$Animation/AnimationTree.set("parameters/ToolOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		tool_used_emit()

func tool_used_emit() -> void:
		tool_used.emit(current_tool, global_position + last_dir * 16)

func _is_dead() -> void:
	queue_free()
	
func can_dash() -> bool:
	return not is_dashing and dash_cooldown_timer.is_stopped()
	

func _ready() -> void:
	dash_timer.wait_time = dash_duration
	dash_cooldown_timer.wait_time = dash_cooldown
	health_component.max_health = health
	set_character_sprites()

func apply_knockback(damage_position: Vector2, knockback_power: float) -> void:
	var tween = get_tree().create_tween()
	var dir = (position - damage_position).normalized() * knockback_distance * knockback_power
	tween.tween_property(self, "knockback_direction", dir, 0.1)
	tween.tween_property(self, "knockback_direction", Vector2.ZERO, 0.2)
	
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
		move_state_machine.travel("walk")
		var animation_direction = Vector2(round(move_dir.x),round(move_dir.y))
		animation_tree.set("parameters/MoveStateMachine/idle/blend_position", animation_direction)
		animation_tree.set("parameters/MoveStateMachine/walk/blend_position", animation_direction)
		animation_tree.set("parameters/MoveStateMachine/dash/blend_position", animation_direction)
		for animation in GeneralData.TOOL_STATE_ANIMATIONS.values():
			var animation_name: String = "parameters/ToolStateMachine/"+ animation +"/blend_position"
			$Animation/AnimationTree.set(animation_name, animation_direction)
		
	else: 	
		move_state_machine.travel("idle")
	

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
	hurtbox_collision.set_deferred("disabled", true)


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
	hurtbox_collision.set_deferred("disabled", false)
	dash_cooldown_timer.start()


func _on_dash_cooldown_timer_timeout() -> void:
	pass # Replace with function body.


func _on_health_component_damage_taken(damage_position: Vector2, knockpack_power: float) -> void:
	apply_knockback(damage_position, knockpack_power)
	hit_flash_player.play("hit_flash")
	

func _on_health_component_health_changed(current: float, max: float) -> void:
	if health_bar:
		health_bar.update_health_bar(current, max)


func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	if anim_name.begins_with("dash"):
		return
	can_move = false

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	can_move = true
