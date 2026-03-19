class_name ExitObject
extends Area2D

signal playerWantsToExit()

func _ready() -> void:
	GlobalEventBus.subscribe(self)

func _on_area_entered(_area: Area2D) -> void:
	if (_area.get_parent() is Player):
		playerWantsToExit.emit()
	print("Player wants to exit!!!!")
