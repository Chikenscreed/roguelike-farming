extends Node2D
class_name LootDropComponent

@export var item_drop: Array[Item]
@export var item_drop_chances: Array[float]

var pickable_item_scene: PackedScene = preload("res://Scenes/pickableItem.tscn")

func drop_item() -> void:
	if item_drop.size() == 0:
		return
	fix_item_drop_arrays()
	
	var weight_sum: float = 0.0
	for weight in item_drop_chances:
		weight_sum += weight
	
	var random: float = randf_range(0.0, weight_sum)
	var drop_value: float = 0.0
	
	for i in item_drop_chances.size():
		drop_value += item_drop_chances[i]
		if random <= drop_value:
			if item_drop[i] == null:
				return
			
			var item = pickable_item_scene.instantiate()
			item.itemData = item_drop[i]
			item.global_position = global_position
			
			get_parent().get_tree().current_scene.call_deferred("add_child", item)
			break

func fix_item_drop_arrays() -> void:
	if item_drop_chances.size() < item_drop.size():
		item_drop_chances.resize(item_drop.size())
	elif item_drop.size() < item_drop_chances.size():
		item_drop.resize(item_drop_chances.size())
