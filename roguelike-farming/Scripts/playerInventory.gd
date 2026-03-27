class_name Playerinventory
extends Node

var playerData: PlayerInventoryData


func addSkill(skillId: int) -> void: 
	if (!playerData.skillTreeSkills.has(skillId)):
		playerData.skillTreeSkills.append(skillId)

func expandDungeon(expansion: Vector2i) -> void:
	playerData.dungeonDimension += expansion

func addTileToInventory(tile: Tile_Data) -> void:
	playerData.addTileToInventory(tile)

func removeTilefromIventory(tile: Tile_Data) -> void:
	playerData.removeTileFromInventory(tile)


func addItem(item: Item) -> void:
	if (item is CollectableTile):
		var newTile: Tile_Data = generateRandomTile()
		addTileToInventory(newTile)
	else:
		playerData.addItem(item)

func removeBulkItems(dir: Dictionary[Item, int]) -> void:
	playerData.bulkremoveItems(dir)


func generateRandomTile() -> Tile_Data:
	var newTile: Tile_Data = Tile_Data.new()
	newTile.entranceComposition = [Tile_Data.ENTRANCE_COMPOSITIONS.LINE, Tile_Data.ENTRANCE_COMPOSITIONS.L, Tile_Data.ENTRANCE_COMPOSITIONS.X, Tile_Data.ENTRANCE_COMPOSITIONS.SINGLE, Tile_Data.ENTRANCE_COMPOSITIONS.T].pick_random()
	newTile.tileStyle = [preload("res://Resources/DungeonThings/TileStyles/baseStyle.tres"), preload("res://Resources/DungeonThings/TileStyles/differentStyle.tres")].pick_random()
	return newTile
