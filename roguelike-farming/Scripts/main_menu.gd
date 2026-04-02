extends Control

@export_file("*.tscn") var character_creator_path: String 

func _ready() -> void:
	Talo.players.identify("gamesAndGaminCourse", Talo.players.generate_identifier())
	Talo.players.identified.connect(sendTestEvent)

func sendTestEvent(player: TaloPlayer) -> void:
		Talo.events.track("TestTaloevent", {
		"test": "success"
	})

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(character_creator_path)
	GlobalPersesistance.loadSaveFile()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
