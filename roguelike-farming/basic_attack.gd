extends Node2D
class_name BasicAttack

@onready var hitbox: HitboxComponent = $Hitbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.disable()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
func attack():
	hitbox.enable()
	print("Attacked!")
	
	await get_tree().create_timer(0.1).timeout
	hitbox.disable()
