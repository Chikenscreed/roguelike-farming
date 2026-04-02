class_name NewDungeonStyle
extends SkillFunctionality

@export var dungeonRoomStyle: TileStyle

func execute() -> void:
	GlobalPlayerInventory.addNewDungeonStyle(dungeonRoomStyle)
