extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10
const NO_HEALTH = 0
var health : float

signal isDead

func _ready():
	health = MAX_HEALTH
	
func damage(attack: Attack):
	health -= attack.attack_damage
	
	if health <= NO_HEALTH:
		isDead.emit()
		get_parent().queue_free()
