class_name PlayerDataCollector
extends Node

var counterForID: int 
var allDataPoints: Array[DataPoint] = []

@export var path: String = "res://SAVES/PLAYERDATA/"
@export var dataFileName = "playerData"
@export var fileEnding = ".xlsx" 

# this class should gather the player data
# it should also save them at the end of the gaming session

func increseId() -> void:
	counterForID += 1

func getTimestamp() -> String:
	return Time.get_datetime_string_from_unix_time(Time.get_unix_time_from_system())

func addDataPoint(cathegory: DataPoint.CATHEGORIES, dataString: String) -> void:
	allDataPoints.append(DataPoint.new().createDataPoint(getTimestamp(), cathegory, dataString, counterForID))
	increseId()
	pass 


func playerGotHit(damage: int, enemy: String, healtBeforeHit: int) -> void:
	#which enemy, how much damage
	Talo.events.track("Player got hit", {
		"Enemy" : enemy,
		"Damage": str(damage),
		"HealthBeforeHit": str(healtBeforeHit)
	})
	var dataString = "Enemy: " + enemy + "|damage: " + str(damage) + "|healthBeforeHit: " + str(healtBeforeHit)
	addDataPoint(DataPoint.CATHEGORIES.PLAYER_HIT, dataString)
	pass

func tilesPlacedVsPossibelTiles(tilesByPlayer: int, tileInventory: int, freeTiles: int) -> void:
	Talo.events.track("tiles place vs possible tiles", {
		"tilesByPlayer" : str(tilesByPlayer),
		"tileInventory" : str(tileInventory),
		"freeTiles" : str(freeTiles),
		"freeTilesFilledByPlayerPercentage" : str(float(tilesByPlayer)/freeTiles*100)
	})
	var dataString = "tilesByPlayer: " + str(tilesByPlayer) + "|tilesInInventory: " + str(tileInventory) + "|allSlotsPossibleTiles: " + str(freeTiles)
	addDataPoint(DataPoint.CATHEGORIES.TILES_PLACED, dataString)
	#tiles player placed, free Tiles in Frame player could place tiles on, Num of Tiles in playerInventory
	pass

func traversedRooms(actuallyTraversed: int, allRooms: int) -> void:
	#player actually walked through, tiles placed in Frame
	#disclaimer: The player could have placed the tiles in a way he could not reach all tiles
	#also doubles as player successfully finished a dungeon
	Talo.events.track("Traversed rooms", {
		"traversedRooms" : str(actuallyTraversed),
		"allRooms" : str(allRooms),
		"traversalPercentage": str(float(actuallyTraversed)/allRooms*100)
	})
	var dataString = "traversedRooms: " + str(actuallyTraversed) + "|alLRooms: " +str(allRooms)
	addDataPoint(DataPoint.CATHEGORIES.ROOMS_TRAVERSED, dataString)
	pass


func playerDied() -> void:
	Talo.events.track("Player Died")
	addDataPoint(DataPoint.CATHEGORIES.PLAYER_DEATH, "")
	#enemy, damage taken, playerHp before death <- this data would also be in playerGotHit tho
	pass

func activatedSkillsInSkillTree() -> void:
	#when should this be evaluated? either at the end of the game
	#or player opend skill tree, player closed skill tree, player activated Skill -> see if the skill tree is self explainatory
	pass


func saveData() -> void:
	if(!DirAccess.dir_exists_absolute(path)):
		DirAccess.make_dir_absolute(path)
	var fileName : String = dataFileName + str(DirAccess.get_files_at(path).size())
	var file = FileAccess.open(path+fileName+fileEnding, FileAccess.WRITE_READ)
	file.store_csv_line(["Id", "Timestamp", "Cathegory", "Data"])
	for point in allDataPoints:
		file.store_csv_line([point.id, point.timestamp, point.enumString, point.dataString])
	file.close()
	
	
	
