class_name ExitObject
extends Area2D

func _on_area_entered(_area: Area2D) -> void:
	print("Player wants to exit!!!!")
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/farming_base.tscn")
