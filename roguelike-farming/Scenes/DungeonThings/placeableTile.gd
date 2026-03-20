class_name PlacableTile
extends Node2D

@onready var frame_tile_slot: MapTile = $FrameTileSlot
@onready var count: Label = $FrameTileSlot/count


func setup(tileData: Tile_Data, count: int) -> void:
	frame_tile_slot.setTile(tileData,false)
	self.count.text = str(count)
