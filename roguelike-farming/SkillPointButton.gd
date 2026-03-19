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
			
@export var activated: bool:
	set(value):
		activated = value
		if activated:
			applyActivatedVisual()

@export var followingSkills: Array[SkillTreePointButton] = []:
	set(value):
		followingSkills = value
		paintLines()
@export var previousSkills: Array[SkillTreePointButton] = []

const lockedColorLine: Color = Color(0.187, 0.187, 0.187, 1.0)
const unlockedColorLine: Color = Color(0.0, 0.42, 0.843, 1.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_pressed)
	self.mouse_entered.connect(showInfo)
	self.mouse_exited.connect(removeInfo)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func applyActivatedVisual() -> void: 
	self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	paintLines()

func _on_pressed() -> void:
	if onePreviousSkillUnlocked() and !activated:
		skill.skillBase.functionality.execute()
		activated = true
		GlobalPlayerInventory.addSkill(skill.skill_id)
		

func paintLines() -> void:
	for child in get_parent().get_children():
		if child.is_in_group(self.name):
			child.queue_free()
	
	for skill in followingSkills:
		var line: Line2D = Line2D.new()
		line.add_to_group(self.name)
		line.z_index = -1
		line.width = 5
		if(activated):
			line.default_color = unlockedColorLine
		else:
			line.default_color = lockedColorLine
		line.add_point(Vector2(self.position+self.size/2))
		line.add_point(Vector2(skill.position+skill.size/2))
		get_parent().add_child(line)
		pass

func onePreviousSkillUnlocked() -> bool:
	if previousSkills.is_empty():
		return true
	else:
		for skill in previousSkills:
			if skill.activated:
				return true
		return false


func showInfo() -> void:
	await get_tree().create_timer(0.2).timeout
	if(is_hovered()):
		var desc: SkillDescriptionpanel = preload("res://Scenes/SkillTreeStuff/skill_description.tscn").instantiate()
		add_child(desc)
		desc.showDesc(skill.skillBase.description, Vector2(size))
	pass
	
func removeInfo() -> void:
	if get_children().size() >0:
		get_child(0).queue_free()
