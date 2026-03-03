class_name DungeonRoom
extends Node2D

#cell coordinates for all the doors. In final version maybe calculated so it can adjust to dungeon size
var coordsNorthDoor: Vector2i = Vector2i(8,0)
var coordsEasttDoor: Vector2i = Vector2i(17, 8)
var coordsSouthDoor: Vector2i = Vector2i(8, 17)
var coordsWestDoor: Vector2i = Vector2i(0, 8)


var entranceScene = preload("res://Scenes/components/mapComponents/entrance.tscn")
var entranceDimNorthSouth = Vector2(24,8)
var entranceDimEastWest = Vector2(8,24)

@onready var tile_map_layer: TileMapLayer = $TileMapLayer2

# doors are patterns in the tilemap. Currently it is not possible to name them, so we have to follow this schema
const patternIndexNorth: int = 0
const patternIndexEast: int = 1
const patternIndexSouth: int = 2
const patternIndexWest: int = 3

const tileSize = 16

var tileData: Tile_Data = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#calcDoorCords()
	setUp()
	pass # Replace with function body.

func setTileData(data) -> void:
	tileData = data

#
#func calcDoorCords() -> void:
	#print(tile_map_layer.get_used_rect().size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func addDoors(n: bool, e: bool, s: bool, w:bool) -> void:
	if(n):
		tile_map_layer.set_pattern(coordsNorthDoor, tile_map_layer.tile_set.get_pattern(patternIndexNorth))
		addEntrance(Enums.DIRECTION.NORTH)
	if(e):
		tile_map_layer.set_pattern(coordsEasttDoor, tile_map_layer.tile_set.get_pattern(patternIndexEast))
		addEntrance(Enums.DIRECTION.EAST)
	if(s):
		tile_map_layer.set_pattern(coordsSouthDoor, tile_map_layer.tile_set.get_pattern(patternIndexSouth))
		addEntrance(Enums.DIRECTION.SOUTH)
	if(w):
		tile_map_layer.set_pattern(coordsWestDoor, tile_map_layer.tile_set.get_pattern(patternIndexWest))
		addEntrance(Enums.DIRECTION.WEST)

func setUp() -> void:
	addDoors(tileData.north, tileData.east, tileData.south, tileData.west)

func addEntrance(direction: Enums.DIRECTION) -> void: 
	var entrance: Node2D = entranceScene.instantiate()
	add_child(entrance)
	match direction:
		Enums.DIRECTION.NORTH:
			entrance.setDimensions(entranceDimNorthSouth)
			entrance.position = transformDoorCoordsToEntranceCords(coordsNorthDoor)+ Vector2(tileSize, 0.75*tileSize)
		Enums.DIRECTION.SOUTH:
			entrance.setDimensions(entranceDimNorthSouth)
			entrance.position = transformDoorCoordsToEntranceCords(coordsSouthDoor)+ Vector2(tileSize, 0.25*tileSize)
		Enums.DIRECTION.EAST:
			entrance.setDimensions(entranceDimEastWest)
			entrance.position = transformDoorCoordsToEntranceCords(coordsEasttDoor) + Vector2(0.25*tileSize, tileSize)
		Enums.DIRECTION.WEST:
			entrance.setDimensions(entranceDimEastWest)
			entrance.position = transformDoorCoordsToEntranceCords(coordsWestDoor) + Vector2(0.75*tileSize, tileSize)

func transformDoorCoordsToEntranceCords(coords: Vector2) -> Vector2:
	var x = coords.x * tileSize
	var y = coords.y * tileSize 
	return Vector2(x,y)
