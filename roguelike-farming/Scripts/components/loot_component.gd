extends Node2D
class_name LootDropComponent

@export var item_drop: Array[Item]
@export var item_drop_chances: Array[float]

var direction_distance: float = 16

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
			_apply_knockback(item)
			
			get_parent().get_tree().current_scene.call_deferred("add_child", item)
			break

func fix_item_drop_arrays() -> void:
	if item_drop_chances.size() < item_drop.size():
		item_drop_chances.resize(item_drop.size())
	elif item_drop.size() < item_drop_chances.size():
		item_drop.resize(item_drop_chances.size())


func drop_tile() -> void:
	var droppedTile = pickable_item_scene.instantiate()
	droppedTile.global_position = global_position + Vector2(8,8)
	get_parent().get_tree().current_scene.call_deferred("add_child", droppedTile)
	droppedTile.itemData = preload("res://Resources/Items/TileDropped.tres")
	_apply_knockback(droppedTile)
	

func _apply_knockback(item: pickableItem) -> void:
	var tween = get_tree().create_tween()
	var random_direction = item.position +  Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * direction_distance
	tween.tween_property(item, "position", random_direction, 0.1)
