extends Control
class_name HealthBar

@export var back_color: Color
@export var fill_color: Color

@onready var progress_bar: TextureProgressBar = $ProgressBar


# Applies the exported `back_color` and `fill_color` to this specific progress bar 
# by duplicating and overriding its theme styleboxes.
func _ready() -> void:
	var back_style := progress_bar.get_theme_stylebox("background").duplicate()
	back_style.bg_color = back_color
	# gets shared StyleBox for the "fill" part of the bar and makes it unique to be able to edit it
	var fill_style := progress_bar.get_theme_stylebox("fill").duplicate()
	fill_style.bg_color = fill_color #sets color of the copy to fill_color
	
	#applies custom styleboxes
	progress_bar.add_theme_stylebox_override("background", back_style)
	progress_bar.add_theme_stylebox_override("fill", fill_style)
	

# Signal callback for when the connected HealthComponent's health changes.
# Calculates the health ratio (e.g., 0.8) and calls `update_bar` to update the visuals.
func update_health_bar(current: float, max_health: float) -> void:
	progress_bar.value = current
	progress_bar.max_value = max_health
