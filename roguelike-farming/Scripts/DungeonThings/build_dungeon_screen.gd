extends Control



signal exportAllRooms(dict: Dictionary)
@onready var dungeon_frame: DungeonFrame = $DungeonFrame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			removeTile()
			pass
		elif event.button_index == MOUSE_BUTTON_MIDDLE and event.pressed:
			rotateTile()
			pass
	
	
func rotateTile() -> void:
	var all = getTheTileFromScreen()
	for hit in all:
		var something = hit.collider as MapTile
		if something != null :
			print("Current rep: ", something.tileData.currentEntrances, "NEW REP: ", something.tileData.currentEntrances >>1)
			something.tileData.currentEntrances = (something.tileData.currentEntrances << 1) | ((something.tileData.currentEntrances & Tile_Data.WEST) >> 3)
			something.showEntrances()
			

	

func getTheTileFromScreen() -> Array[Dictionary]: 
	var mousePos = get_global_mouse_position()
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mousePos
	query.collide_with_areas = true
	
	var intersections = space.intersect_point(query)
	return intersections
		



func removeTile() -> void: 
	for hit in getTheTileFromScreen():
		var something = hit.collider as MapTile
		if something != null:
			if !something.pregeneratedTile and something.mapSlot:
				something.resetTileData()
				break 


func _on_frame_tile_slot_area_entered(_area: Area2D) -> void:
	print("something entered")
	pass # Replace with function body.

#this dunction wopuld have to transform the slots into a dictionary with Vector2 as keys?
func submitDungeon() -> void: 
	var counter = 0
	var allRooms: Dictionary = {}
	var x: int = 0
	var y: int = 0
	for room in dungeon_frame.get_children():
		room = room as MapTile
		x = counter / dungeon_frame.dimensions.x
		y = counter % dungeon_frame.dimensions.y
		allRooms.set(Vector2(x,y), room.tileData)
		counter += 1
	exportAllRooms.emit(allRooms)
	self.visible = false
	pass


func _on_button_pressed() -> void:
	submitDungeon()
