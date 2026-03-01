class_name DungeonRoom
extends Node2D

#cell coordinates for all the doors. 
var coordsNorthDoor: Vector2i 
var coordeasttDoor: Vector2i
var coordsSouthDoor: Vector2i
var coordsWestDoor: Vector2i


@onready var tile_map_layer: TileMapLayer = $TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	calcDoorCords()
	pass # Replace with function body.


func calcDoorCords() -> void:
	print(tile_map_layer.get_used_rect().size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func addDoors(n: bool, e: bool, s: bool, w:bool) -> void:
	pass
#	tile_map_layer.set_cell()
