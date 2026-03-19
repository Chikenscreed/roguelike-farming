extends Node2D

@export var tile_size := 16
@export var carrot_scene: PackedScene
@export var dungeon_scene: PackedScene
@export var skilltree_scene: PackedScene

var planeted_crop_tiles : Array[Vector2i] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_player_action(position: Vector2) -> void:
	var grid_coord: Vector2i = Vector2i(int(position.x / tile_size), int(position.y / tile_size))
	var cell = $Layers/SoilLayer.get_cell_tile_data(grid_coord) as TileData
	if cell and cell.get_custom_data("farmable") and not grid_coord in planeted_crop_tiles:
		var plant = carrot_scene.instantiate()
		plant.position = grid_coord * tile_size + Vector2i(8,5)
		plant.add_to_group("crops")
		$Objects.add_child(plant)
		planeted_crop_tiles.append(grid_coord)



func _on_button_pressed() -> void:
	var crops = $Objects.get_children().filter(is_crop)
	for crop in crops:
		crop.grow()

func is_crop(node: Node) -> bool:
	return node.is_in_group("crops")


func _on_dungeon_button_pressed() -> void:
	get_tree().change_scene_to_packed(dungeon_scene)


func _on_skilltree_button_pressed() -> void:
	get_tree().change_scene_to_packed(skilltree_scene)
