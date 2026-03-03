class_name EventBus
extends Node

var dungeonManager: DungeonManager


func subscribe(node: Node) -> void:
	if (node is DungeonManager):
		dungeonManager = node
	if(node is Entrance):
		connectEntrancesWithDungeonManager(node)


func connectEntrancesWithDungeonManager(entrance: Entrance) -> void:
	entrance.movePlayerToNextRoom.connect(dungeonManager.movePlayerToNextRoom)
