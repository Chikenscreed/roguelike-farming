extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

func damage(attack: Attack, damage_position: Vector2):
	if health_component:
		health_component.damage(attack, damage_position)
