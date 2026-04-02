class_name Item
extends Resource
##Resource to add every collectable items  


@export var name: String
#currently here because i think we will have an item scene where we can attach the items Resources
@export var sprite: AtlasTexture

#should not be local to scene becuase thsi way we could easier add them into the player inventory
