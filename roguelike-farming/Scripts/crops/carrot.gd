extends Node2D
class_name Crop

var harvestable: bool = false
var growth: int = 0
var grid_coord: Vector2i

signal harvested(grid_coord: Vector2i)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Hitbox/CollisionShape2D.disabled = true
	grid_coord = Vector2i(int(global_position.x / GeneralData.TILE_SIZE), int(global_position.y / GeneralData.TILE_SIZE))
	update_data()

func setup(_harvestable: bool, _growth: int, _grid_coord: Vector2i) -> void:
	harvestable = _harvestable
	growth = _growth
	grid_coord = _grid_coord
	$Sprite2D.frame = growth

func grow(growthSteps: int) -> void:
	
	if growthSteps <= 0:
		update_data()
		return
	
	if harvestable:
		return
		
	if growth < $Sprite2D.hframes - 1:
		growth += 1
		
	if growth == $Sprite2D.hframes - 1:
		harvestable = true
		
	$Sprite2D.frame = growth
	$Hitbox/CollisionShape2D.disabled = !harvestable
	
	
	grow(growthSteps-1)

func _on_harvested() -> void:
	harvested.emit(grid_coord)

func update_data() -> void:
	var dict = GeneralData.CROP_TEMPLATE.duplicate()
	dict["crop_type"] = Enum.Crop.CARROT
	dict["harvestable"] = harvestable
	dict["growth"] = growth
	dict["grid_coord"] = grid_coord
	GlobalPlayerInventory.playerData.farming_base_data.add_crop(grid_coord, dict)
