class_name Player
extends CharacterBody2D


@export var speed = 300.0
@export var health = 150.0
@export var dash_duration := 0.5
@export var dash_speed_multi := 2.5
@export var dash_cooldown := 0.5

@onready var dash_cooldown_timer: Timer = $dash_cooldown_timer
@onready var dash_timer: Timer = $dash_timer
@onready var visuals: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $Hitbox/CollisionShape2D

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
	update_rotation()
	move_and_slide()
	if Input.is_action_just_pressed("dash") and can_dash():
		dash()
	
func _process(_delta: float) -> void:
	check_action_input()

func _is_dead() -> void:
	queue_free()
	
func can_dash() -> bool:
	return not is_dashing and dash_cooldown_timer.is_stopped()
	

func _ready() -> void:
	dash_timer.wait_time = dash_duration
	dash_cooldown_timer.wait_time = dash_cooldown

func check_action_input():
	if Input.is_action_just_pressed("action"):
		action.emit(global_position)

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

func dash() -> void:
	if not dash_cooldown_timer.is_stopped():
		return
	is_dashing = true

	dash_timer.start()
	visuals.modulate.a = 0.5
	collision.set_deferred("disabled", true)

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
func update_rotation() -> void:
	if move_dir == Vector2.ZERO:
		return
	
	if move_dir.x >= 0.1:
		visuals.scale = Vector2(-1, 1)
	else:
		visuals.scale = Vector2(1, 1)


func _on_dash_timer_timeout() -> void:
	is_dashing = false
	visuals.modulate.a = 1.0
	move_dir = Vector2.ZERO
	collision.set_deferred("disabled", false)
	dash_cooldown_timer.start()


func _on_dash_cooldown_timer_timeout() -> void:
	pass # Replace with function body.
