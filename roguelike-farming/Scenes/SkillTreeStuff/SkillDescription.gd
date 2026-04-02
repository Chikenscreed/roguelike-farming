class_name SkillDescriptionpanel
extends Panel

@onready var description: Label = $Description
@onready var v_flow_container: HFlowContainer = $VFlowContainer
@export var itemPrev: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func showDesc(desc: String, pos: Vector2, neededItems: Dictionary[Item, int]) -> void:
	description.text = desc
	position = pos
	showNeededItems(neededItems)
	self.set_deferred("visible", true)


func showNeededItems(neededItems: Dictionary[Item, int]) -> void:
	for key in neededItems.keys():
		var newItem: ItemPreview = itemPrev.instantiate()
		v_flow_container.add_child(newItem)
		newItem.setup(key, neededItems.get(key))
