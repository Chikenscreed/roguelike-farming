class_name DataPoint
extends Resource

var timestamp: String
var enumString: String
var dataString: String
var id: int

func createDataPoint(timestamp: String, cathegory: CATHEGORIES, dataString: String, c: int) -> DataPoint:
	self.timestamp = timestamp
	enumString = matchEnumToString(cathegory)
	self.dataString = dataString
	id = c
	return self


func matchEnumToString(c: CATHEGORIES) -> String:
	match c:
		CATHEGORIES.PLAYER_HIT:
			return "playerHit"
		CATHEGORIES.PLAYER_DEATH:
			return "playerDeath"
		CATHEGORIES.ROOMS_TRAVERSED:
			return "roomsTraversed"
		CATHEGORIES.TILES_PLACED:
			return "tilesPlaced"
		CATHEGORIES.SKILLTREE_ACTIVATED:
			return "skilltreeActivated"
		_:
			return "None"


enum CATHEGORIES{
	PLAYER_HIT,
	PLAYER_DEATH,
	ROOMS_TRAVERSED,
	TILES_PLACED,
	SKILLTREE_ACTIVATED
}
