class_name Enemy
extends Node2D

@onready var loot_drop : LootDropComponent = $"Loot Drops"
@onready var health_bar: HealthBar = $HealthBar

@onready var hit_flash_player: AnimationPlayer = $Sprite2D/HitFlashPlayer

func _on_health_component_is_dead() -> void:
	loot_drop.drop_item()



func _on_health_component_health_changed(current: float, max: float) -> void:
	if health_bar:
		health_bar.update_health_bar(current, max)


func _on_health_component_damage_taken(damage_position: Vector2) -> void:
	hit_flash_player.play("hit_flash")
