extends Node2D

@export var tile_size := 16
@export var carrot_scene: PackedScene
@export_file("*.tscn") var dungeon_scene_path: String 
@export var skilltree_scene: PackedScene

var planeted_crop_tiles : Array[Vector2i] = []



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_player_action(pos: Vector2) -> void:
	var grid_coord: Vector2i = Vector2i(int(pos.x / tile_size), int(pos.y / tile_size))
	var cell = $Layers/SoilLayer.get_cell_tile_data(grid_coord) as TileData
	if cell and cell.get_custom_data("farmable") and not grid_coord in planeted_crop_tiles:
		var plant = carrot_scene.instantiate()
		plant.position = grid_coord * tile_size + Vector2i(8,5)
		plant.add_to_group("crops")
		$Crops.add_child(plant)
		planeted_crop_tiles.append(grid_coord)

func _on_player_tool_used(tool: Enum.Tool, pos: Vector2) -> void:
	var grid_coord: Vector2i = Vector2i(int(pos.x / tile_size), int(pos.y / tile_size))
	match tool:
		Enum.Tool.HOE:
			$Layers/SoilLayer.set_cells_terrain_connect([grid_coord], 0, 0)


func _on_button_pressed() -> void:
	var crops = $Crops.get_children().filter(is_crop)
	for crop in crops:
		crop.grow()

func is_crop(node: Node) -> bool:
	return node.is_in_group("crops")


func _on_dungeon_button_pressed() -> void:
	get_tree().change_scene_to_file(dungeon_scene_path)


func _on_skilltree_button_pressed() -> void:
	get_tree().change_scene_to_packed(skilltree_scene)


func _on_button_2_pressed() -> void:
	GlobalPlayerDataCollector.saveData()
	GlobalPersesistance.saveGame()
