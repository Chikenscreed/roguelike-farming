class_name PlayerDataCollector
extends Node

var counterForID: int 
var allDataPoints: Array[DataPoint] = []

# this class should gather the player data
# it should also save them at the end of the gaming session

func increseId() -> void:
	counterForID += 1

func getTimestamp() -> String:
	return Time.get_datetime_string_from_unix_time(Time.get_unix_time_from_system())


func playerGotHit() -> void:
	#which enemy, how much damage
	pass

func tilesPlacedVsPossibelTiles(tilesByPlayer: int, tileInventory: int, freeTiles: int) -> void:
	var dataString = "tilesByPlayer: " + str(tilesByPlayer) + "|tilesInInventory: " + str(tileInventory) + "|allSlotsPossibleTiles: " + str(freeTiles)
	allDataPoints.append(DataPoint.new().createDataPoint(getTimestamp(), DataPoint.CATHEGORIES.TILES_PLACED, dataString, counterForID))
	increseId()
	#tiles player placed, free Tiles in Frame player could place tiles on, Num of Tiles in playerInventory
	pass

func traversedRooms(actuallyTraversed: int, allRooms: int) -> void:
	#player actually walked through, tiles placed in Frame
	#disclaimer: The player could have placed the tiles in a way he could not reach all tiles
	#also doubles as player successfully finished a dungeon
	var dataString = "traversedRooms: " + str(actuallyTraversed) + "|alLRooms: " +str(allRooms)
	allDataPoints.append(DataPoint.new().createDataPoint(getTimestamp(), DataPoint.CATHEGORIES.ROOMS_TRAVERSED, dataString, counterForID))
	increseId()
	pass


func playerDied() -> void:
	#enemy, damage taken, playerHp before death <- this data would also be in playerGotHit tho
	pass

func activatedSkillsInSkillTree() -> void:
	#when should this be evaluated? either at the end of the game
	#or player opend skill tree, player closed skill tree, player activated Skill -> see if teh skill tree is self explainatory
	pass
