## @tool only here so it updates in the editor while adding them into it
@tool
class_name SkillTreePointButton
extends TextureButton

@export var skill : SkillPoint:
	set(value):
		skill = value
		if (value != null):
			self.texture_normal = skill.skillBase.sprite
			self.size = Vector2(skill.skillBase.sprite.get_size())

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	skill.skillBase.functionality.execute()
