extends Control

@export_file("*.tscn") var farming_base_path: String 


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file(farming_base_path)
