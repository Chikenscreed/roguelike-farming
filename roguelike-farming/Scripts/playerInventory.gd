class_name Playerinventory
extends Node

@export var tileInventory: Dictionary[Tile_Data, int] = {
	preload("res://Resources/LineExample.tres") : 5,
	preload("res://Resources/T_Example.tres") : 3
}
