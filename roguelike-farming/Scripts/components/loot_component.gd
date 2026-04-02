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
	var allItems: Array[Item] = []
	for i in item_drop_chances.size():
		drop_value += item_drop_chances[i]
		if random <= drop_value:
			if item_drop[i] == null:
				return
			allItems.append(item_drop[i])
			break
	allItems.append( preload("res://Resources/Items/TileDropped.tres"))
	placeDrops(allItems)

func placeDrops(items: Array[Item]) -> void:
	for item in items:
		var pitem = pickable_item_scene.instantiate()
		pitem.itemData = item
		pitem.global_position = global_position
		#This does look ugly ngl but i dont know how to do it prettier? Maybe if you give the specific node as parameter? 
		get_parent().get_parent().call_deferred("add_child", pitem)
		pitem.position = get_parent().position+Vector2(randi_range(-15, 15), randi_range(-15,15))
	pass

func fix_item_drop_arrays() -> void:
	if item_drop_chances.size() < item_drop.size():
		item_drop_chances.resize(item_drop.size())
	elif item_drop.size() < item_drop_chances.size():
		item_drop.resize(item_drop_chances.size())
