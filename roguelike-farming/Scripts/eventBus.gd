class_name EventBus
extends Node

var dungeonManager: DungeonManager
var exit: ExitObject


func subscribe(node: Node) -> void:
	if (node is DungeonManager):
		dungeonManager = node
	if(node is Entrance):
		connectEntrancesWithDungeonManager(node)
	if (node is ExitObject):
		exit = node
		connectExitWithDungeonManager()


func connectEntrancesWithDungeonManager(entrance: Entrance) -> void:
	entrance.movePlayerToNextRoom.connect(dungeonManager.movePlayerToNextRoom)

func connectExitWithDungeonManager() -> void:
	if(exit and dungeonManager):
		exit.playerWantsToExit.connect(dungeonManager.playerReachedEnd)
