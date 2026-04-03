extends Node2D

@export var tile_size := 16
@export var carrot_scene: PackedScene
@export_file("*.tscn") var dungeon_scene_path: String 
@export var skilltree_scene: PackedScene

var planeted_crop_tiles : Array[Vector2i] = []
var farming_base_data: FarmingBaseData = GlobalPlayerInventory.playerData.farming_base_data


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data()


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func load_data() -> void:
	$Layers/SoilLayer.set_cells_terrain_connect(farming_base_data.placed_soil, 0, 0)
	planeted_crop_tiles = farming_base_data.planeted_crop_tiles.keys()
	for grid_coord in farming_base_data.planeted_crop_tiles:
		var crop_path = GeneralData.CROPS_DATA[farming_base_data.planeted_crop_tiles[grid_coord]["crop_type"]]
		var crop_scene: PackedScene = load(crop_path)
		var crop = crop_scene.instantiate()
		setup_plant_data(crop, farming_base_data.planeted_crop_tiles[grid_coord])
		add_plant(crop, grid_coord)
		
		
func _on_player_action(pos: Vector2) -> void:
	var grid_coord: Vector2i = Vector2i(int(pos.x / tile_size), int(pos.y / tile_size))
	var cell = $Layers/SoilLayer.get_cell_tile_data(grid_coord) as TileData
	if cell and cell.get_custom_data("farmable") and not grid_coord in planeted_crop_tiles:
		var plant = carrot_scene.instantiate()
		add_plant(plant, grid_coord)
		planeted_crop_tiles.append(grid_coord)

func setup_plant_data(plant: Crop, dict: Dictionary) -> void:
	plant.setup(dict["harvestable"], dict["growth"], dict["grid_coord"])

func add_plant(plant, grid_coord:Vector2i) -> void:
	plant.position = grid_coord * tile_size + Vector2i(8,5)
	plant.add_to_group("crops")
	plant.harvested.connect(crop_harvested)
	$Crops.add_child(plant)

func _on_player_tool_used(tool: Enum.Tool, pos: Vector2) -> void:
	var grid_coord: Vector2i = Vector2i(int(pos.x / tile_size), int(pos.y / tile_size))
	match tool:
		Enum.Tool.HOE:
			$Layers/SoilLayer.set_cells_terrain_connect([grid_coord], 0, 0)
			farming_base_data.add_soil(grid_coord)

func crop_harvested(grid_coord: Vector2i) -> void:
	planeted_crop_tiles.erase(grid_coord)
	farming_base_data.planeted_crop_tiles.erase(grid_coord)

func _on_button_pressed() -> void:
	var crops = $Crops.get_children().filter(is_crop)
	for crop in crops:
		crop.grow(1)

func is_crop(node: Node) -> bool:
	return node.is_in_group("crops")


func _on_dungeon_button_pressed() -> void:
	get_tree().change_scene_to_file(dungeon_scene_path)


func _on_skilltree_button_pressed() -> void:
	get_tree().change_scene_to_packed(skilltree_scene)


func _on_button_2_pressed() -> void:
	GlobalPlayerDataCollector.saveData()
	GlobalPersesistance.saveGame()
