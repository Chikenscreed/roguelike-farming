extends Node
class_name FarmingBaseData

var placed_soil: Array[Vector2i] = []
var planeted_crop_tiles : Dictionary[Vector2i, Dictionary] = {}

func add_soil(soil_coordinate: Vector2i) -> void:
	placed_soil.append(soil_coordinate)

func add_crop(coordinate: Vector2i, plant_data: Dictionary) -> void:
	planeted_crop_tiles[coordinate] = plant_data
