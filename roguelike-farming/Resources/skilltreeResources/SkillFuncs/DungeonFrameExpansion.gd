class_name DungeonFrameExpansion
extends SkillFunctionality

@export var direction: ExpansionDirection

func execute() -> void:
	print("Expanding the dungeonframe by ", direction)

enum ExpansionDirection{
	HORIZONTAL,
	VERTICAL
}
