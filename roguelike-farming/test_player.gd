extends CharacterBody2D


const SPEED = 300.0

var knockback = Vector2.ZERO
var knockback_timer: float = 0.0

func _physics_process(delta: float) -> void:
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	else:
		movement()

	move_and_slide()



func _is_dead() -> void:
	queue_free()


func apply_knockback(damage_position: Vector2) -> void:
	var force = 150
	knockback = (global_position - damage_position).normalized() * force
	knockback_timer = 0.7

func movement() -> void:
	var yDirection := Input.get_axis("up", "down")
	if yDirection:
		velocity.y = yDirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
