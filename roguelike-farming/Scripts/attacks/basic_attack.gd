extends Node2D
class_name BasicAttack

@onready var hitbox: CollisionShape2D = $"Attack Component/CollisionShape2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
func attack():
	hitbox.disabled = false
	await get_tree().create_timer(1).timeout
	hitbox.disabled = true
