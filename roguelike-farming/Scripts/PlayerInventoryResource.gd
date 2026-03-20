class_name PlayerInventoryData
extends Resource

signal tileInventoryChanged()

@export var tileInventory: Dictionary[Tile_Data, int] = {
	preload("res://Resources/LineExample.tres") : 5,
	preload("res://Resources/T_Example.tres") : 3,
	preload("res://Resources/differentTile.tres"): 4
}


##all activated SkillIDs saved here
@export var skillTreeSkills: Array[int] = []

@export var dungeonDimension: Vector2i = Vector2i(3,3)


func removeTileFromInventory(tile: Tile_Data) -> void:
	var matchedResult: Tile_Data =  getMatchingInvTile(tile)
	if matchedResult!= null:
		tileInventory.set(matchedResult,tileInventory.get(matchedResult)-1)
		tileInventoryChanged.emit()

func getMatchingInvTile(tile:Tile_Data)-> Tile_Data:
	for key in tileInventory.keys():
		key = key as Tile_Data
		if key.is_equal(tile):
			return key
	return null
