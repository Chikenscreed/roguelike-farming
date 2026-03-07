class_name MapTile
extends Area2D

##This are the tiles the player will be able to move to a slot to place it there. Component also reused for 

@onready var background: Sprite2D = $background
@onready var north: Sprite2D = $north
@onready var east: Sprite2D = $east
@onready var south: Sprite2D = $south
@onready var west: Sprite2D = $west
@onready var extra: Sprite2D = $extra


#bit masks for the entrances: 
#const NORTH = 0b0001
#const EAST = 0b0010
#const SOUTH = 0b0100
#const WEST = 0b1000

var is_dragging : bool = false
var isPressed: bool = false

var snapBackPos: Vector2



##This boolean is needed to make MapSlotTiles not draggable. 
@export var mapSlot: bool 
@export var pregeneratedTile: bool

## if a tile gets dragged to the slot, the slot should show the current tile_data. Also later probably needed to connect the tiles together
@export var tileData: Tile_Data


var rotateOnlyOnce: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if tileData:
		tileData.currentEntrances = tileData.entranceComposition
		createVisualisation()
	if !mapSlot:
		snapBackPos = position
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass
		

func _on_mouse_entered() -> void:
	print("Mouse is on it")
	if (!mapSlot):
		is_dragging = true
	pass # Replace with function body.

func _on_mouse_exited() -> void:
	is_dragging = false


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and is_dragging:
			if event.pressed:
				isPressed = true
				print("something happened")
			else:
				isPressed = false
				print ("stopped pressing")
				snapback()
				#getSlot()
				testWithIntersectPoint()
	if event is InputEventMouseMotion and isPressed:
		self.position = get_global_mouse_position()

func resetTileData() -> void:
	tileData = null
	background.texture = preload("uid://c4mux65qg06i2")
	removeAllEntrances()

func removeAllEntrances() -> void: 
	north.visible = false
	east.visible = false
	south.visible = false
	west.visible = false

func snapback() -> void:
	var glideTween = create_tween()
	glideTween.tween_property(self, "position", snapBackPos, 0.1)
	#position = snapBackPos

func setTile(data: Tile_Data) -> void:
	print(data.name)
	self.tileData = data.duplicate()
	createVisualisation()

func getSlot() -> void: 
	if(get_overlapping_areas().size() >0):
		var chosenSlot: MapTile = get_overlapping_areas()[0] as MapTile
		chosenSlot.setTile(self.tileData)
	pass 


func testWithIntersectPoint() -> void: 
	var mousePos = get_global_mouse_position()
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mousePos
	query.collide_with_areas = true
	for slot in space.intersect_point(query):
		var s: MapTile = slot.collider as MapTile
		if s != null:
			if(s.mapSlot and !s.pregeneratedTile):
				s.setTile(self.tileData)


func showEntrances() -> void: 
	removeAllEntrances()
	if (tileData.isNorth()):
		north.visible = true
	if(tileData.isEast()):
		east.visible = true
	if(tileData.isSouth()):
		south.visible = true
	if(tileData.isWest()):
		west.visible = true
	pass

func showExtras() -> void:
	if tileData.extras != []: 
		extra.texture = tileData.extras[0].previewSprite
		extra.visible = true

func createVisualisation() -> void:
	showEntrances()
	showExtras()
	background.texture = tileData.tileStyle.previewTileBackground
	pass
