class_name PlacableTile
extends Node2D

@onready var frame_tile_slot: MapTile = $FrameTileSlot
@onready var count: Label = $FrameTileSlot/count


func setup(tileData: Tile_Data, count: int) -> void:
	frame_tile_slot.setTile(tileData,false)
	self.count.text = str(count)



func grayOut() -> void:
	modulate = Color(0.234, 0.234, 0.234, 1.0)
	#timer needed becuase otherwise tile would stay stuck at frame. more elegant solutions welcome
	await get_tree().create_timer(0.2).timeout
	process_mode = Node.PROCESS_MODE_DISABLED
	

func reactivate() -> void:
	modulate = Color(1.0, 1.0, 1.0, 1.0)
	process_mode= Node.PROCESS_MODE_INHERIT
