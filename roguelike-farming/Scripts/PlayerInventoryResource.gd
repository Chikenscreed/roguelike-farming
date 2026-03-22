class_name PlayerInventoryData
extends Resource

signal tileInventoryChanged()

@export var tileInventory: Dictionary[Tile_Data, int] = {
	preload("res://Resources/DungeonThings/completeDungeonTiles/LineExample.tres") : 5,
	preload("res://Resources/DungeonThings/completeDungeonTiles/T_Example.tres") : 3,
	preload("res://Resources/DungeonThings/completeDungeonTiles/differentTile.tres"): 4
}


##all activated SkillIDs saved here
@export var skillTreeSkills: Array[int] = []

@export var dungeonDimension: Vector2i = Vector2i(3,3)

@export var ItemInventory: Dictionary[Item, int] = {
	preload("res://Resources/Items/Carrot.tres"): 5
}


func removeTileFromInventory(tile: Tile_Data) -> void:
	var matchedResult: Tile_Data =  getMatchingInvTile(tile)
	if matchedResult!= null:
		var res = tileInventory.get(matchedResult)-1
		tileInventory.set(matchedResult,tileInventory.get(matchedResult)-1)
		tileInventoryChanged.emit()

func addTileToInventory(tile: Tile_Data) -> void:
	var matchedKey: Tile_Data = getMatchingInvTile(tile)
	if (matchedKey != null):
		tileInventory.set(matchedKey, tileInventory.get(matchedKey)+1)
	else:
		var newKey = Tile_Data.new()
		newKey.entranceComposition = tile.entranceComposition
		newKey.extras = tile.extras
		newKey.tileStyle = tile.tileStyle
		tileInventory.set(newKey, 1)
	tileInventoryChanged.emit()

func getMatchingInvTile(tile:Tile_Data)-> Tile_Data:
	for key in tileInventory.keys():
		key = key as Tile_Data
		if key.is_equal(tile):
			return key
	return null

func addItem(item: Item) -> void: 
	if ItemInventory.has(item):
		ItemInventory.set(item, ItemInventory.get(item)+1)
	else:
		ItemInventory.set(item, 1)


func bulkremoveItems(dic: Dictionary[Item, int]) -> void:
	for key in dic.keys():
		ItemInventory.set(key, ItemInventory.get(key)-dic.get(key))
	pass
