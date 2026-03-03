class_name Enums
enum DIRECTION {
	NORTH,
	EAST,
	SOUTH,
	WEST
}

func translateToString(e: Enums.DIRECTION) -> String:
	match e:
		0:
			return "north"
		1:
			return "east"
		2:
			return "south"
		3: 
			return "west"
		_: 
			return "Error"
