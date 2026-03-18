class_name SkillTree
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drawLines()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func drawLines() -> void:
	for child in get_children(false):
		if(child is SkillTreePointButton):
			if(!child.followingSkills.is_empty()):
				child.paintLines()
		if(child is Line2D):
			child.queue_free()
