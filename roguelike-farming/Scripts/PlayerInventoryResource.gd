class_name PlayerInventoryData
extends Resource

@export var tileInventory: Dictionary[Tile_Data, int] = {
	preload("res://Resources/LineExample.tres") : 5,
	preload("res://Resources/T_Example.tres") : 3,
	preload("res://Resources/differentTile.tres"): 4
}


##all activated SkillIDs saved here
@export var skillTreeSkills: Array[int] = []

@export var dungeonDimension: Vector2i = Vector2i(3,3)
