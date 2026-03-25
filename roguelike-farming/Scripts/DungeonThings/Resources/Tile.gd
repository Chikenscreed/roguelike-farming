class_name Tile_Data
extends Resource

##represents a Tile. Is called "Tile_Data" because "TileData" is a class of Godot

@export var name: String

@export var entranceComposition: ENTRANCE_COMPOSITIONS
@export var currentEntrances: int

##a boolean for each door/entrance

const NORTH = 0b0001
const EAST = 0b0010
const SOUTH = 0b0100
const WEST = 0b1000

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

func isNorth() -> bool:
	return currentEntrances & NORTH
	
func isEast() -> bool:
	return currentEntrances & EAST

func isSouth() -> bool:
	return currentEntrances & SOUTH

func isWest() -> bool:
	return currentEntrances & WEST
	

func is_equal(other: Tile_Data) -> bool:
	if other == null:
		return false
	else:
		return entranceComposition == other.entranceComposition and tileStyle == other.tileStyle and extras == other.extras
