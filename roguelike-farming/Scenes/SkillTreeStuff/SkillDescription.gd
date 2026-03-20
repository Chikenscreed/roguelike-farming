class_name SkillDescriptionpanel
extends Panel

@onready var description: Label = $Description

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func showDesc(desc: String, pos: Vector2) -> void:
	description.text = desc
	position = pos
	self.set_deferred("visible", true)
