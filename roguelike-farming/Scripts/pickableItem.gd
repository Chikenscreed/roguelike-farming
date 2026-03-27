class_name pickableItem
extends Area2D

@onready var collision: CollisionShape2D = $collision
@onready var sprite: Sprite2D = $Sprite


@export var itemData: Item


func _ready() -> void:
	if itemData:
		setItemData()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setItemData() -> void:
	collision.shape.set_size(itemData.sprite.get_size())
	sprite.texture = itemData.sprite  

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GlobalPlayerInventory.addItem(itemData)
		queue_free()
