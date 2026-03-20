class_name Playerinventory
extends Node

var playerData: PlayerInventoryData


func addSkill(skillId: int) -> void: 
	if (!playerData.skillTreeSkills.has(skillId)):
		playerData.skillTreeSkills.append(skillId)

func expandDungeon(expansion: Vector2i) -> void:
	playerData.dungeonDimension += expansion
