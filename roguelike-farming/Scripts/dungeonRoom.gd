class_name DungeonRoom
extends Node2D

#cell coordinates for all the doors. 
var coordsNorthDoor: Vector2i = Vector2i(8,0)
var coordeasttDoor: Vector2i = Vector2i(17, 8)
var coordsSouthDoor: Vector2i = Vector2i(8, 17)
var coordsWestDoor: Vector2i = Vector2i(0, 8)


@onready var tile_map_layer: TileMapLayer = $TileMapLayer2

const patternIndexNorth: int = 0
const patternIndexEast: int = 1
const patternIndexSouth: int = 2
const patternIndexWest: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	calcDoorCords()
	setUp()
	pass # Replace with function body.


func calcDoorCords() -> void:
	print(tile_map_layer.get_used_rect().size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func addDoors(n: bool, e: bool, s: bool, w:bool) -> void:
	if(n):
		tile_map_layer.set_pattern(coordsNorthDoor, tile_map_layer.tile_set.get_pattern(patternIndexNorth))
	if(e):
		tile_map_layer.set_pattern(coordeasttDoor, tile_map_layer.tile_set.get_pattern(patternIndexEast))
	if(s):
		tile_map_layer.set_pattern(coordsSouthDoor, tile_map_layer.tile_set.get_pattern(patternIndexSouth))
	if(w):
		tile_map_layer.set_pattern(coordsWestDoor, tile_map_layer.tile_set.get_pattern(patternIndexWest))
		#tile_map_layer.set_pattern(coordsNorthDoor, tile_map_layer.get_pattern())
#	tile_map_layer.set_cell()

func setUp() -> void:
	var data = preload("uid://r4bvmlw0cgtd")
	addDoors(data.north, data.east, data.south, data.west)
