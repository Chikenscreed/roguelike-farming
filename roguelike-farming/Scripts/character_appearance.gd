extends Node


var body_collection = {
	0 : preload("res://Sprites/Player/Player_Base/Player_Base_animations.png")
}

var chest_collection = {
	0 : null,
	1 : preload("res://Sprites/Player/Chest/Farmer_Shirt/Farmer_Shirt_1_Black.png"),
	2 : preload("res://Sprites/Player/Chest/Lumberjack_Shirt/Lumberjack_Shirt_1_Black.png"),
	3 : preload("res://Sprites/Player/Chest/OG_Shirt/Shirt_1_Black.png"),
	4 : preload("res://Sprites/Player/Chest/Plate_Chest/Plate_Chest_Iron.png"),
	5 : preload("res://Sprites/Player/Chest/Royal_Shirt/Royal_Shirt_1_Black.png")
}

var hair_collection = {
	0 : null,
	1 : preload("res://Sprites/Player/Head/Hair_1/Hair_1_Black.png"),
	2 : preload("res://Sprites/Player/Head/Hair_2/Hair_2_Black.png"),
	3 : preload("res://Sprites/Player/Head/Hair_3/Hair_3_Brown.png"),
	4 : preload("res://Sprites/Player/Head/Hair_4/Hair_4_Ginger.png"),
	5 : preload("res://Sprites/Player/Head/Hair_5/Hair_5_Blonde.png"),
	6 : preload("res://Sprites/Player/Head/Hair_6/Hair_6_Brown.png")
}

var legs_collection = {
	0 : null,
	1 : preload("res://Sprites/Player/Legs/Farmer_Pants/Farmer_Pants_1_Black.png"),
	2 : preload("res://Sprites/Player/Legs/OG_Pants/Pants_1_Black.png"),
	3 : preload("res://Sprites/Player/Legs/Plate_Legs/Plate_Legs_Iron.png"),
	4 : preload("res://Sprites/Player/Legs/Royal_Pants/Royal_Pantst_1_Red.png")
}

var hands_collection = {
	0 : preload("res://Sprites/Player/Hands/Hands_1_Bare.png")
}

var feet_collection = {
	0 : null,
	1 : preload("res://Sprites/Player/Feet/Shoes_1_Black.png"),
	2 : preload("res://Sprites/Player/Feet/Shoes_1_Blue.png"),
	3 : preload("res://Sprites/Player/Feet/Shoes_1_Brown.png"),
	4 : preload("res://Sprites/Player/Feet/Shoes_1_Green.png"),
	5 : preload("res://Sprites/Player/Feet/Shoes_1_Orange.png")
}

var accessory_collection = {
	0 : null,
	1 : preload("res://Sprites/Player/Accessories/Farmer_Hat_1.png")
}

var selected_body = 0
var selected_chest = 0
var selected_hair = 0
var selected_legs = 0
var selected_hands = 0
var selected_feet = 0
var selected_accessory = 0
