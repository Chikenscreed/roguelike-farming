class_name PersistenceNode
extends Node

@export var path: String = "res://SAVES/"

@export var saveFileName = "saveFile"
@export var fileEnding = ".tres" 

##This component manages the saving of the game and loading it again
func saveGame() -> void:
	if(!DirAccess.dir_exists_absolute(path)):
		DirAccess.make_dir_absolute(path)
	print(ResourceSaver.save(GlobalPlayerInventory.playerData, path+saveFileName+str(DirAccess.open(path).get_files().size())+fileEnding))
	#get_tree().free()


func loadSaveFile() -> void:
	if(DirAccess.dir_exists_absolute(path)):
		if(DirAccess.open(path).get_files().is_empty()):
			GlobalPlayerInventory.playerData = PlayerInventoryData.new()
		else:
			GlobalPlayerInventory.playerData = ResourceLoader.load(path+saveFileName+str(DirAccess.open(path).get_files().size()-1)+fileEnding, "PlayerinventoryData").duplicate()
	var allFiles: int = DirAccess.open(path).get_files().size()
