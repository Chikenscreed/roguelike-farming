extends Node2D
class_name BasicAttack

@onready var hitbox: CollisionShape2D = $"Attack Component/CollisionShape2D"
@onready var attack_component: AttackComponent = $"Attack Component"

@export var attack_damage: float
@export var critical := false
@export var knockback_power:= 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.disabled = true
	
	attack_component.attack_damage = attack_damage
	attack_component.critical = critical
	attack_component.knockback_power = knockback_power
	
func attack(attacker_pos: Vector2):
	look_at(attacker_pos)
	attack_component.damage_position = attacker_pos
	hitbox.disabled = false
	await get_tree().create_timer(0.2).timeout
	hitbox.disabled = true
