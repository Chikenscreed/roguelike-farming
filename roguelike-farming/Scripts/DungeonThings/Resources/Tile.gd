class_name Tile_Data
extends Resource

##represents a Tile. Is called "Tile_Data" because "TileData" is a class of Godot

@export var name: String

@export var entranceComposition: ENTRANCE_COMPOSITIONS
@export var currentEntrances: int

##a boolean for each door/entrance
#@export_category("Entrances")
#@export var north : bool
#@export var east : bool
#@export var south : bool
#@export var west : bool

## Texture to show during the building screen
#@export_category("SpriteRep")
#@export var sprite : CompressedTexture2D

##extraStuff like chest or exit
@export var extras: Array[DungeonExtras]

@export var tileStyle: TileStyle



enum ENTRANCE_COMPOSITIONS{
	SINGLE = 1,
	LINE = 5,
	L = 3,
	T = 7,
	X = 15
	
}
