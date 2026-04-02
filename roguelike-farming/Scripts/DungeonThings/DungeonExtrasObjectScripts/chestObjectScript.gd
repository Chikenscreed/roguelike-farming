class_name ChestObject
extends Area2D

@onready var loot_drops: LootDropComponent = $"Loot Drops"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_entered(_area: Area2D) -> void:
	var _ar = _area
	print("Player entered")
	loot_drops.drop_item()
	queue_free()
