extends Area2D

@export var attack_damage := 2

func _on_hitbox_area_entered(_area: Area2D) -> void:
	if _area is HitboxComponent:
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		_area.damage(attack, global_position)
