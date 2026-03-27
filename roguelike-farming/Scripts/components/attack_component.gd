extends Area2D
class_name AttackComponent

@export var attack_damage: float
@export var critical := false
@export var knockback_power:= 1.0

var damage_position: Vector2

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		print("Attacked: " + str(area.get_parent()))
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.critical = critical
		attack.knockback_power = knockback_power
		attack.damage_position = damage_position
		if (self.get_parent() is Enemy):
			if(area.get_parent() is Player):
				GlobalPlayerDataCollector.playerGotHit(attack_damage, "basicEnemy", area.health_component.current_health)
		area.damage(attack)
