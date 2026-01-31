extends Node2D

@export var hud: CanvasLayer;

func _ready() -> void:
	hud.select_mask(0)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var keycode = event.keycode
		if keycode >= KEY_1 and keycode <= KEY_9:
			hud.select_mask(keycode - KEY_1)
		# The following code is just to try out hud changes
		if keycode == KEY_J:
			hud.collect_mask(1)
		if keycode == KEY_K:
			hud.collect_mask(2)            
		# The following code is just to try out hud changes     
