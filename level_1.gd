extends Node2D

@export var hud: CanvasLayer;

func _ready() -> void:
	print(hud.selected_mask_idx)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var keycode = event.keycode
		if keycode >= KEY_1 and keycode <= KEY_9:
			hud.selected_mask_idx = keycode - KEY_1
		if keycode == KEY_P:
			hud.collected_mask_cnt += 1   
   
