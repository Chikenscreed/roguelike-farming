extends Control



signal exportAllRooms(dict: Dictionary, startRoom: Vector2i)
@onready var dungeon_frame: DungeonFrame = $DungeonFrame
@onready var panel: Node2D = $Panel

@export var currentSelectedTiles: Array[Tile_Data]

signal resetPlayer()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resetPlayer.emit()
	placeTileSelection()
	GlobalPlayerInventory.playerData.tileInventoryChanged.connect(updateCounts)
	dungeon_frame.tilePutBack.connect(removeFromUsedTiles)
	dungeon_frame.tileAddToList.connect(addUsedTiles)
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
		if something != null && !something.pregeneratedTile:
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
				if(something.tileData != null):
					removeFromUsedTiles(something.tileData)
				something.resetTileData()
				break 


func _on_frame_tile_slot_area_entered(_area: Area2D) -> void:
	print("something entered")
	pass # Replace with function body.

func _on_button_pressed() -> void:
	GlobalPlayerInventory.bulkRemoveTiles(currentSelectedTiles)
	exportAllRooms.emit(dungeon_frame.allRooms, dungeon_frame.startRoom)
	self.set_deferred("visible", false)
	print("pressed the button")

func placeTileSelection() -> void:
	var nextPos : Vector2 = Vector2(32,0)
	var offset: Vector2 = Vector2(35,0)
	var tile = preload("res://Scenes/DungeonThings/placeableTile.tscn") 
	for holder in GlobalPlayerInventory.playerData.tileInventory.keys():
		var newTile: PlacableTile = tile.instantiate() as PlacableTile
		panel.add_child(newTile)
		newTile.frame_tile_slot.SignaltileAdded.connect(addUsedTiles)
		newTile.setup(holder, GlobalPlayerInventory.playerData.tileInventory.get(holder))
		newTile.position = nextPos
		newTile.frame_tile_slot.snapBackPos = newTile.frame_tile_slot.position
		nextPos += offset
		pass
	updateCounts()

func _on_back_pressed() -> void:
	#are the carrots and groths saved here? 
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/farming_base.tscn")


func updateCounts() -> void:
	for tile in panel.get_children():
		if tile is PlacableTile:
			var count = GlobalPlayerInventory.playerData.tileInventory.get(GlobalPlayerInventory.playerData.getMatchingInvTile(tile.frame_tile_slot.tileData))
			var countFromCurrentSelection = countOfMatchingTiles(tile.frame_tile_slot.tileData)
			count -= countFromCurrentSelection
			if (count <= 0):
				tile.grayOut()
			else:
				tile.reactivate()
			tile.count.text = str(count)

func addUsedTiles(tile: Tile_Data) -> void:
	tile.currentEntrances = 0
	currentSelectedTiles.append(tile)
	updateCounts()
	pass

func removeFromUsedTiles(tile: Tile_Data) -> void:
	tile.currentEntrances = 0
	for i in currentSelectedTiles:
		if(tile.is_equal(i)):
			currentSelectedTiles.erase(i)
			break
	updateCounts()
	pass

func countOfMatchingTiles(tileFromPlayerInv: Tile_Data) -> int:
	var counter = 0
	for tile in currentSelectedTiles:
		if(tileFromPlayerInv.is_equal(tile)):
			counter += 1
	return counter
