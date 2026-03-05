extends Control


@onready var tile_frame_2: Control = $TileFrame2

signal exportAllRooms(dict: Dictionary)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_frame_tile_slot_area_entered(area: Area2D) -> void:
	print("something entered")
	pass # Replace with function body.

#this dunction wopuld have to transform the slots into a dictionary with Vector2 as keys?
func submitDungeon() -> void: 
	var counter = 0
	var allRooms: Dictionary = {}
	var x: int = 0
	var y: int =0
	for room in tile_frame_2.get_children():
		room = room as MapTile
		x = counter / 3
		y = counter % 3
		allRooms.set(Vector2(x,y), room.tileData)
		counter += 1
	exportAllRooms.emit(allRooms)
	self.visible = false
	pass


func _on_button_pressed() -> void:
	submitDungeon()
