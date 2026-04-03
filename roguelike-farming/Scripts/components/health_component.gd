extends Node
class_name HealthComponent

signal damage_taken(damage_position: Vector2, knockback_power: float)
signal is_dead
signal health_changed(current: float, max: float)

@export var max_health := 10.0
var current_health : float

func _ready() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)
	
func take_damage(attack: Attack) -> void:
	current_health -= attack.attack_damage 
	current_health = max(current_health, 0)
	damage_taken.emit(attack.damage_position, attack.knockback_power)
	health_changed.emit(current_health, max_health)
	
	print(current_health)
	
	if current_health <= 0:
		is_dead.emit()
		if (get_parent() is Player):
			GlobalPlayerDataCollector.playerDied()
