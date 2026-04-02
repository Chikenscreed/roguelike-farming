class_name ItemPreview
extends PanelContainer

##To show what Items the player needs to unlock the specific Skill in Skilltree
@export var itemSprite: TextureRect
@export var haveVsNeeded: Label

@export var item_preview: FlowContainer


func setup(item: Item, needed: int) -> void:
	itemSprite.texture = item.sprite
	var countInInventory = GlobalPlayerInventory.getItemCount(item)
	haveVsNeeded.text = str(countInInventory) +" / " + str(needed) 
	if(countInInventory >= needed):
		haveVsNeeded.set("theme_override_colors/font_color", Color(0.196, 0.584, 0.161, 1.0))
	else:
		haveVsNeeded.set("theme_override_colors/font_color", Color(0.858, 0.216, 0.245, 1.0))
