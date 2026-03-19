class_name DungeonFrameExpansion
extends SkillFunctionality

@export var direction: ExpansionDirection

func execute() -> void:
	var expansion: Vector2i = Vector2i(1,0) 
	if direction == ExpansionDirection.VERTICAL:
		expansion = Vector2i(0,1)
	GlobalPlayerInventory.expandDungeon(expansion)
	print("Expanding the dungeonframe by ", direction)

enum ExpansionDirection{
	HORIZONTAL,
	VERTICAL
}
