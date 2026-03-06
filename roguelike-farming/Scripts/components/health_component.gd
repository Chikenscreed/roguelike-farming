extends Node
class_name HealthComponent

signal on_player_hit
signal on_player_died
signal on_health_changed(current: float, max: float)

@onready var flash_timer: Timer = $FlashTimer


var sprite_ref: Sprite2D
var max_health := 10.0
var current_health := 1.0

func setup(max_health: float, node_sprite: Sprite2D) -> void:
	print("setting max health to: ", max_health)
	self.max_health = max_health
	current_health = max_health
	
	sprite_ref = node_sprite
	
	on_health_changed.emit(current_health, max_health)
	
func take_damage(value: float) -> void:
	if current_health <= 0:
		return
		
	set_flash_material()
	current_health -= value
	current_health = max(current_health, 0)
	on_player_hit.emit()
	on_health_changed.emit(current_health, max_health)
	
	if current_health <= 0:
		print("Player died")
		current_health = 0
		on_player_died.emit()
		die()
		
func die() -> void:
	owner.queue_free()

func set_flash_material() -> void:
	if sprite_ref:
		sprite_ref.material = Global.FLASH_MATERIAL
		flash_timer.start()
	
func _on_flash_timer_timeout() -> void:
	if sprite_ref:
		sprite_ref.material = null
