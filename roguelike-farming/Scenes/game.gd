extends Node

@onready var test_player: Player = $TestPlayer


func _ready() -> void:
	test_player.global_position = Vector2(320,180)
