class_name MapTile
extends Area2D

##This are the tiles the player will be able to move to a slot to place it there. Component also reused for 


@onready var sprite: Sprite2D = $Sprite

var is_dragging : bool = false
var isPressed: bool = false



##This boolean is needed to make MapSlotTiles not draggable. 
@export var mapSlot: bool 

## if a tile gets dragged to the slot, the slot should show the current tile_data. Also later probably needed to connect the tiles together
@export var tileData: Tile_Data


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if tileData:
		sprite.texture = tileData.sprite
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
		




func _on_mouse_entered() -> void:
	print("Mouse is on it")
	if (!mapSlot):
		is_dragging = true
	pass # Replace with function body.

func _on_mouse_exited() -> void:
	is_dragging = false


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and is_dragging:
		if event.pressed:
			isPressed = true
			print("something happened")
		else:
			isPressed = false
			print ("stopped pressing")
			#getSlot()
			testWithIntersectPoint()
	if event is InputEventMouseMotion and isPressed:
		self.position = get_global_mouse_position()

func setTile(data: Tile_Data) -> void:
	print(data.name)
	self.tileData = data
	self.sprite.texture = data.sprite

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
		if(s.mapSlot):
			s.setTile(self.tileData)
