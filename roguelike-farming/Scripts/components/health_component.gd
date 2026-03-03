extends Node2D
class_name HealthComponent

@export var MAX_HEALTH: float = 10
@export var DEFENSE: float = 0
const NO_HEALTH = 0
var health : float

signal isDead
signal damage_taken(damage_position: Vector2)

func _ready():
	health = MAX_HEALTH
	
func damage(attack: Attack, damage_position: Vector2):
	health -= attack.attack_damage * (100 / (100 + DEFENSE))
	
	if health <= NO_HEALTH:
		isDead.emit()
		get_parent().queue_free()
	else:
		damage_taken.emit(damage_position)
