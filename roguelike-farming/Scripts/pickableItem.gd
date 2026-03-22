class_name pickableItem
extends Area2D

@onready var collision: CollisionShape2D = $collision
@onready var sprite: Sprite2D = $Sprite


@export var itemData: Item
	#set(value):
		#itemData = value
		#if is_node_ready():
			#setItemData()


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#print("Current item:" , itemData)
	#if itemData != null:
		#setItemData()
	#pass # Replace with function body.
func _ready() -> void:
	setItemData()
	print("itemData: ", itemData)
	print("itemData class: ", itemData.get_class() if itemData else "NULL")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setItemData() -> void:
	collision.shape.set_size(itemData.sprite.get_size())
	sprite.texture = itemData.sprite  

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("player detected")
		GlobalPlayerInventory.addItem(itemData)
