class_name DungeonFrame
extends Node2D


@export var dimensions: Vector2i
@export var mapTileSceen: PackedScene
var sizeOfTile: int = 32
@export var allRooms: Dictionary = {}
var startRoom: Vector2i


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	placeHolderSlots()
	var exitTile: Vector2i = placeExit()
	var entranceTile: Vector2i = showDungeonEntrance()
	while (entranceTile == exitTile):
		entranceTile = showDungeonEntrance()
	startRoom = entranceTile
	allRooms.get(startRoom).setTile(preload("res://Resources/T_Example.tres"), false)
	print(entranceTile)
	

func placeHolderSlots() -> void: 
	var currentX: int = sizeOfTile/2
	var currentY: int = sizeOfTile/2
	for numY in dimensions.y:
		currentX = sizeOfTile / 2
		for numX in dimensions.x:
			var tile = mapTileSceen.instantiate()
			allRooms.set(Vector2i(numX, numY), tile)
			add_child(tile)
			tile.mapSlot = true
			tile.position = Vector2i(currentX, currentY)
			currentX += sizeOfTile
		currentY += sizeOfTile

func placeExit() ->Vector2i: 
	var indicator = Vector2i(randi_range(0,dimensions.x-1), randi_range(0,dimensions.y-1))
	var exitTileData = Tile_Data.new()
	var exitextra = preload("res://Resources/DungeonExtras/exit.tres")
	var baseStyle = preload("res://Resources/baseStyle.tres")
	exitTileData.extras.append(exitextra)
	exitTileData.tileStyle = baseStyle
	var selectedTile = allRooms.get(indicator) as MapTile 
	exitTileData.currentEntrances =  generateEntrances()
	while( !checkPlacement(indicator, exitTileData)):
		exitTileData.currentEntrances = generateEntrances()
	selectedTile.setTile(exitTileData, true)
	selectedTile.pregeneratedTile = true
	return indicator
	
	
func generateEntrances() -> int:
	return randi_range(1,15)

# checks if there is one "valid" exit. Works on bitmasks 
func checkPlacement(pos: Vector2i, currEntrances: Tile_Data) -> bool:
	var indexY = dimensions.y-1
	var indexX = dimensions.x-1
	var forbiddenEntrances = 0b0000
	if pos.y == 0:
		forbiddenEntrances |= Tile_Data.NORTH
	if pos.y == indexY:
		forbiddenEntrances |= Tile_Data.SOUTH
	if pos.x == 0:
		forbiddenEntrances |= Tile_Data.WEST
	if pos.x == indexX:
		forbiddenEntrances |= Tile_Data.EAST
	var valid = currEntrances.currentEntrances &~ forbiddenEntrances
	return valid >0


func showDungeonEntrance() -> Vector2i:
	var numY = randi_range(0,dimensions.y-1)
	var numX: int
	if(numY == 0 || numY == dimensions.y-1):
		numX = randi_range(0,dimensions.x-1)
	else:
		if randi_range(0,1) == 0:
			numX = 0
		else:
			numX = dimensions.x-1
	return Vector2i(numX, numY)
