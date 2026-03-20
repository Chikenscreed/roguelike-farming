class_name Playerinventory
extends Node

@export var tileInventory: Dictionary[Tile_Data, int] = {
	preload("res://Resources/LineExample.tres") : 5,
	preload("res://Resources/T_Example.tres") : 3
}


##all activated SkillIDs saved here
@export var skillTreeSkills: Array[int] = []

@export var dungeonDimension: Vector2i = Vector2i(3,3)

func addSkill(skillId: int) -> void: 
	if (!skillTreeSkills.has(skillId)):
		skillTreeSkills.append(skillId)


func expandDungeon(expansion: Vector2i) -> void:
	dungeonDimension += expansion
