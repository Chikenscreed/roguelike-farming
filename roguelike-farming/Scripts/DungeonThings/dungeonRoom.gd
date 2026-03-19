class_name DungeonRoom
extends Node2D

#cell coordinates for all the doors. In final version maybe calculated so it can adjust to dungeon size
var coordsNorthDoor: Vector2i 
var coordsEasttDoor: Vector2i
var coordsSouthDoor: Vector2i 
var coordsWestDoor: Vector2i


var entranceScene = preload("res://Scenes/DungeonThings/mapComponents/entrance.tscn")
var entranceDimNorthSouth = Vector2(24,8)
var entranceDimEastWest = Vector2(8,24)

var enemy = preload("res://Scenes/enemy.tscn")

@onready var tile_map_layer: TileMapLayer = $TileMapLayer2
@onready var entrances: Node2D = $Entrances

# doors are patterns in the tilemap. Currently it is not possible to name them, so we have to follow this schema
const patternIndexNorth: int = 0
const patternIndexEast: int = 1
const patternIndexSouth: int = 2
const patternIndexWest: int = 3

const tileSize = 16

var tileData: Tile_Data = null

const middleOfRoom: Vector2 = Vector2(126,126)

## need to send it up to DungeonManager
signal playerReachedExit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	calcDoorCords()
	setUp()
	pass # Replace with function body.

func setTileData(data: Tile_Data) -> void:
	tileData = data

#
func calcDoorCords() -> void:
	var size = tile_map_layer.get_used_rect().size
	print(size)
	var width = size.x
	var height = size.y
	var middleHeight = height/2-1
	var middleWidth = width/2-1
	coordsNorthDoor = Vector2(middleWidth, 0)
	coordsSouthDoor = Vector2(middleWidth, height-1)
	coordsEasttDoor = Vector2(width-1, middleHeight)
	coordsWestDoor = Vector2(0, middleHeight)
	

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func addDoors() -> void:
	if(tileData.isNorth()):
		tile_map_layer.set_pattern(coordsNorthDoor, tile_map_layer.tile_set.get_pattern(patternIndexNorth))
		addEntrance(Enums.DIRECTION.NORTH)
	if(tileData.isEast()):
		tile_map_layer.set_pattern(coordsEasttDoor, tile_map_layer.tile_set.get_pattern(patternIndexEast))
		addEntrance(Enums.DIRECTION.EAST)
	if(tileData.isSouth()):
		tile_map_layer.set_pattern(coordsSouthDoor, tile_map_layer.tile_set.get_pattern(patternIndexSouth))
		addEntrance(Enums.DIRECTION.SOUTH)
	if(tileData.isWest()):
		tile_map_layer.set_pattern(coordsWestDoor, tile_map_layer.tile_set.get_pattern(patternIndexWest))
		addEntrance(Enums.DIRECTION.WEST)

func setUp() -> void:
	addDoors()
	addExtras()
	#just a precaution so no hitbox that should not be hit now is disabled
	makeUnplayable()

func addEntrance(direction: Enums.DIRECTION) -> void: 
	var entrance: Node2D = entranceScene.instantiate()
	entrance.setDirection(direction)
	entrances.add_child(entrance)
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


func makePlayable() -> void:
	self.visible = true
	
	tile_map_layer.set_deferred("enabled", true)
	self.set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)

func makeUnplayable() -> void:
	self.visible = false
	
	tile_map_layer.set_deferred("enabled", false)
	self.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
	

func addExtras() -> void:
	for extra in tileData.extras:
		var newPart = extra.scenetoBePlaced.instantiate()
		if newPart is ExitObject:
			newPart.area_entered.connect(callreachedExit)
		newPart.position = middleOfRoom
		add_child(newPart)
		
	if tileData.extras == []:
		var newEnemy = enemy.instantiate()
		newEnemy.position = Vector2(randi_range(2,16)*16, randi_range(2,16)*16)
		add_child(newEnemy)


func callreachedExit() -> void:
	print("Transfering signal")
	playerReachedExit.emit()
