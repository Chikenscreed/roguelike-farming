class_name Enemy
extends Node2D

@export var health = 10

@onready var loot_drop : LootDropComponent = $"Loot Drops"
@onready var health_component : HealthComponent = $HealthComponent
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	health_component.setup(health, sprite)


func disableAllAreas() -> void:
	for child in get_children():
		if child is Area2D:
			child.set_deferred("monitoring", false)
			child.set_deferred("monitorable", false)

func enableAllAreas() -> void: 
	for child in get_children():
		if child is Area2D:
			child.set_deferred("monitoring", true)
			child.set_deferred("monitorable", true)


func _on_hurtbox_on_damaged(hitbox: HitboxComponent) -> void:
	if health_component.current_health <= 0:
		return
	health_component.take_damage(hitbox.damage)
