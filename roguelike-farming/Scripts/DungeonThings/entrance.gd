class_name Entrance
extends Area2D

##to be placed in dungeon to be able to switch to next room


signal movePlayerToNextRoom(direction: Enums.DIRECTION)

var direction: Enums.DIRECTION
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalEventBus.subscribe(self)
#	self.area_entered(_area: Area2D).connect(self._on_area_entered)
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func setDimensions(dim: Vector2) -> void:
	collision_shape_2d.shape = RectangleShape2D.new()
	collision_shape_2d.shape.size = dim
	
func setDirection(dir: Enums.DIRECTION) -> void: 
	direction = dir
	


func _on_area_entered(_area: Area2D) -> void:
	print("Something got detected")
	if (!_area is Entrance and !_area is MapTile):
		movePlayerToNextRoom.emit(direction)
