class_name DungeonFrame
extends Node2D


@export var dimensions: Vector2i
@export var mapTileSceen: PackedScene
var sizeOfTile: int = 32
@export var allRooms: Dictionary = {}
var startRoom: Vector2i


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dimensions = GlobalPlayerInventory.dungeonDimension
	placeHolderSlots()
	var exitTile: Vector2i = placeExit()
	var entranceTile: Vector2i = showDungeonEntrance()
	while (entranceTile == exitTile):
		entranceTile = showDungeonEntrance()
	placePOITiles([exitTile, entranceTile])
	startRoom = entranceTile
	#this is only for now to show the start entrance
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
	var indicator = generatePOITilePlacement()
	var exitTileData = Tile_Data.new()
	var exitextra = preload("res://Resources/DungeonExtras/exit.tres")
	var baseStyle = preload("res://Resources/baseStyle.tres")
	exitTileData.extras.append(exitextra)
	exitTileData.tileStyle = baseStyle
	placePregeneratedTiles(exitTileData, indicator)
	return indicator
	

func generatePOITilePlacement() -> Vector2i:
	return Vector2i(randi_range(0,dimensions.x-1), randi_range(0,dimensions.y-1))

func generateEntrances() -> int:
	return randi_range(1,15)

func placePregeneratedTiles(tile: Tile_Data, pos: Vector2i) -> void:
	var selectedTile = allRooms.get(pos) as MapTile 
	tile.currentEntrances =  generateEntrances()
	while( !checkPlacement(pos, tile)):
		tile.currentEntrances = generateEntrances()
	selectedTile.setTile(tile, true)
	selectedTile.pregeneratedTile = true	
	pass


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

func calcNumOfPOITiles() -> int:
	return max(1, floor(dimensions.x * dimensions.y) / 12)

#placing POI Tiles to encourage Player to keep exploring
func placePOITiles(takenPos: Array[Vector2i]) -> void: 
	for num in calcNumOfPOITiles():
		#maybe later we will have a selection, for now we only have chests
		var poiTile: Tile_Data = Tile_Data.new()
		var extra = preload("res://Resources/DungeonExtras/chest.tres")
		var baseStyle = preload("res://Resources/baseStyle.tres")
		poiTile.extras.append(extra)
		poiTile.tileStyle = baseStyle
		var pos: Vector2i = generatePOITilePlacement()
		while takenPos.has(pos):
			pos = generatePOITilePlacement()
		takenPos.append(pos)
		poiTile.currentEntrances = generateEntrances()
		while !checkPlacement(pos, poiTile):
			poiTile.currentEntrances = generateEntrances()
		placePregeneratedTiles(poiTile, pos)
	pass
