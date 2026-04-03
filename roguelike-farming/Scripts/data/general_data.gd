extends Node

const TILE_SIZE: int = 16

const TOOL_STATE_ANIMATIONS = {
	Enum.Tool.HOE: 'Hoe',
	Enum.Tool.SWORD: 'Sword',
	}

const CROPS_DATA: Dictionary[Enum.Crop, String] = {
	Enum.Crop.CARROT: "res://Scenes/crops/carrot.tscn"
}

const CROP_TEMPLATE: Dictionary = {
	"crop_type": Enum.Crop.CARROT,
	"harvestable": false,
	"growth": 0,
	"grid_coord": Vector2i.ZERO
}
