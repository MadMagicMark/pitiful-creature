extends Node2D

@export var hud: CanvasLayer;

func _ready() -> void:
	hud.update_mask_ui()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var keycode = event.keycode
		if keycode >= KEY_1 and keycode <= KEY_9:
			var mask_idx = keycode - KEY_1
			GameManager.wear_mask(GameManager.MASK_NAMES[mask_idx])
			hud.update_mask_ui()
		# The following code is just to try out hud changes
		if keycode == KEY_J:
			GameManager.acquire_mask(GameManager.MASK_2)
			hud.update_mask_ui()
		if keycode == KEY_K:
			GameManager.acquire_mask(GameManager.MASK_3)
			hud.update_mask_ui()
		if keycode == KEY_L:
			GameManager.acquire_mask(GameManager.MASK_4)
			hud.update_mask_ui()
		if keycode == KEY_M:
			get_tree().change_scene_to_file("res://assets/doorPuzzle/doorpuzzle.tscn")
		# The following code is just to try out hud changes     
