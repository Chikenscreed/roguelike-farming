extends Control

@export_file("*.tscn") var character_creator_path: String 


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(character_creator_path)


func _on_exit_button_pressed() -> void:
	get_tree().quit()
