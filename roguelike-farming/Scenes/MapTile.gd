class_name MapTile
extends Area2D

##This are the tiles the player will be able to move to a slot to place it there. Component also reused for 

@onready var sprite: Sprite2D = $Sprite

var is_dargging : bool = false
var isPressed: bool = false

##This boolean is needed to make MapSlotTiles not draggable. 
@export var mapSlot: bool 

## if a tile gets dragged to the slot, the slot should show the current tile_data. Also later probably needed to connect the tiles together
@export var tileData: Tile_Data
	#set(newData):
		#if newData:
			#sprite.texture = newData.sprite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if tileData:
		sprite.texture = tileData.sprite
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_dargging and isPressed:
		self.position = get_global_mouse_position()




func _on_mouse_entered() -> void:
	print("Mouse is on it")
	if (!mapSlot):
		is_dargging = true
	pass # Replace with function body.

func _on_mouse_exited() -> void:
	is_dargging = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and is_dargging:
		if event.pressed:
			isPressed = true
			print("something happened")
		else:
			isPressed = false
			print ("stopped pressing")
