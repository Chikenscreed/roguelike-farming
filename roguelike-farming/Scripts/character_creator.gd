extends Control

@onready var chest: Sprite2D = $Skeleton/Chest
@onready var hair: Sprite2D = $Skeleton/Hair
@onready var legs: Sprite2D = $Skeleton/Legs
@onready var hands: Sprite2D = $Skeleton/Hands
@onready var feet: Sprite2D = $Skeleton/Feet
@onready var accessory: Sprite2D = $Skeleton/Accessory

@export_file("*.tscn") var farming_base_path: String 


func previous_sprite(body_part_sprite: Sprite2D, selected_part_variable: String, body_part_collection: Dictionary) -> void:
	var selected_body_part = CharacterAppearance.get(selected_part_variable) - 1
	if selected_body_part < 0:
		selected_body_part = body_part_collection.keys().max()
	CharacterAppearance.set(selected_part_variable, selected_body_part)
	body_part_sprite.texture = body_part_collection.get(selected_body_part)

func next_sprite(body_part_sprite: Sprite2D, selected_part_variable: String, body_part_collection: Dictionary) -> void:
	var selected_body_part = CharacterAppearance.get(selected_part_variable) + 1
	if selected_body_part > body_part_collection.keys().max():
		selected_body_part = 0
	CharacterAppearance.set(selected_part_variable, selected_body_part)
	body_part_sprite.texture = body_part_collection.get(selected_body_part)

func _on_previous_chest_button_pressed() -> void:
	previous_sprite(chest, "selected_chest", CharacterAppearance.chest_collection)

func _on_next_chest_button_pressed() -> void:
	next_sprite(chest, "selected_chest", CharacterAppearance.chest_collection)
	
func _on_previous_hair_button_pressed() -> void:
	previous_sprite(hair, "selected_hair", CharacterAppearance.hair_collection)

func _on_next_hair_button_pressed() -> void:
	next_sprite(hair, "selected_hair", CharacterAppearance.hair_collection)
	
func _on_previous_legs_button_pressed() -> void:
	previous_sprite(legs, "selected_legs", CharacterAppearance.legs_collection)

func _on_next_legs_button_pressed() -> void:
	next_sprite(legs, "selected_legs", CharacterAppearance.legs_collection)

func _on_previous_feet_button_pressed() -> void:
	previous_sprite(feet, "selected_feet", CharacterAppearance.feet_collection)

func _on_next_feet_button_pressed() -> void:
	next_sprite(feet, "selected_feet", CharacterAppearance.feet_collection)

func _on_previous_accessory_button_pressed() -> void:
	previous_sprite(accessory, "selected_accessory", CharacterAppearance.accessory_collection)

func _on_next_accessory_button_pressed() -> void:
	next_sprite(accessory, "selected_accessory", CharacterAppearance.accessory_collection)


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file(farming_base_path)
