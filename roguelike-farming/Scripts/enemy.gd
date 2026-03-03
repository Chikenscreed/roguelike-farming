extends Node2D

@onready var loot_drop : LootDropComponent = $"Loot Drops"
@onready var health : HealthComponent = $Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void: # Nur als ersatz für einen Angriff
	var attack = Attack.new()
	attack.attack_damage = 3
	health.damage(attack, Vector2.ZERO)



func _on_health_is_dead() -> void:
	loot_drop.drop_item()
	queue_free()
