extends Area2D

@export var attack_damage := 2

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		area.damage(attack, global_position)
