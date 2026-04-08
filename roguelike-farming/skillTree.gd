@tool
class_name SkillTree
extends Node2D


var skillDict: Dictionary[int, SkillTreePointButton]
@onready var canvas_layer: CanvasLayer = $CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drawLines()
	generateSkillDictionary()
	activateActivatedSkills()
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


func activateActivatedSkills() -> void:
	for skillId in GlobalPlayerInventory.playerData.skillTreeSkills:
		if skillDict.has(skillId):
			skillDict.get(skillId).activated = true
	pass

func generateSkillDictionary() -> void:
	for child in canvas_layer.get_children():
		if child is SkillTreePointButton:
			skillDict[child.skill.skill_id] = child


func _on_back_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/farming_base.tscn")
