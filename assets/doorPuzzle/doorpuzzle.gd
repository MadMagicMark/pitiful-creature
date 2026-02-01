extends Node2D

@export var button_container: Control
@export var back_scene: String = "res://level1.tscn"
@export var next_scene: String = "res://level2.tscn"
@export var actual_answers: Array[int] = [
	1, 7, 11, 4, 
]
var blue_mask_mode: bool
@export var highlight_anim_time = 0.5
var user_answers: Array[int] = []

var plain_textures: Array[Texture2D] = [
	preload("res://assets/doorPuzzle/rune1.png"),
	preload("res://assets/doorPuzzle/rune2.png"),
	preload("res://assets/doorPuzzle/rune3.png"),
	preload("res://assets/doorPuzzle/rune4.png"),
	preload("res://assets/doorPuzzle/rune5.png"),
	preload("res://assets/doorPuzzle/rune6.png"),
	preload("res://assets/doorPuzzle/rune7.png"),
	preload("res://assets/doorPuzzle/rune8.png"),
	preload("res://assets/doorPuzzle/rune9.png"),
	preload("res://assets/doorPuzzle/rune10.png"),
	preload("res://assets/doorPuzzle/rune11.png"),
	preload("res://assets/doorPuzzle/rune12.png"),
]

var glow_textures: Array[Texture2D] = [
	preload("res://assets/doorPuzzle/rune1.png"),
	preload("res://assets/doorPuzzle/rune2_glow.png"),
	preload("res://assets/doorPuzzle/rune3_glow.png"),
	preload("res://assets/doorPuzzle/rune4_glow.png"),
	preload("res://assets/doorPuzzle/rune5_glow.png"),
	preload("res://assets/doorPuzzle/rune6_glow.png"),
	preload("res://assets/doorPuzzle/rune7_glow.png"),
	preload("res://assets/doorPuzzle/rune8_glow.png"),
	preload("res://assets/doorPuzzle/rune9_glow.png"),
	preload("res://assets/doorPuzzle/rune10_glow.png"),
	preload("res://assets/doorPuzzle/rune11_glow.png"),
	preload("res://assets/doorPuzzle/rune12_glow.png"),
]

func _ready() -> void:
	blue_mask_mode = GameManager.current_mask_name == GameManager.MASK_2
	var idx: int = 0
	for child_button in get_children():
		child_button.input_event.connect(_on_area_2d_input_event.bind(idx))
		idx += 1
	highlight_button_animation(actual_answers[0])

func _on_area_2d_input_event(viewport: Viewport, event: InputEvent, shape_idx: int, button_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		_on_button_pressed(button_idx)

func get_sprite_for_area2d(idx):
	return get_children()[idx].get_child(0)    

func highlight_button_animation(idx: int):
	if blue_mask_mode:
		var btn = get_sprite_for_area2d(idx)
		btn.texture = glow_textures[idx]
		var tween = get_tree().create_tween()
		tween.tween_interval(highlight_anim_time)
		tween.connect("finished", reset_button_highlight.bind(idx))

func reset_button_highlight(idx: int):
	var btn = get_sprite_for_area2d(idx)
	btn.texture = plain_textures[idx]

func _reset_screen():
	for idx in range(len(plain_textures)):
		var btn = get_sprite_for_area2d(idx)
		btn.texture = plain_textures[idx]

func _on_button_pressed(idx: int) -> void:
	if idx == 0:
		_on_back()
	else:
		user_answers.append(idx)
		if user_answers == actual_answers:
			# Highlight most recent correct answer
			var btn = get_sprite_for_area2d(idx)
			btn.texture = glow_textures[idx]
			var tween = get_tree().create_tween()
			tween.tween_interval(highlight_anim_time)
			tween.connect("finished", _on_solve)
		else:
			if not blue_mask_mode:
				var btn = get_sprite_for_area2d(idx)
				btn.texture = glow_textures[idx]
				var tween = get_tree().create_tween()
				tween.tween_interval(highlight_anim_time)
				tween.connect("finished", _reset_screen)
			if correct_so_far():
				# Highlight most recent correct answer
				var btn = get_sprite_for_area2d(idx)
				btn.texture = glow_textures[idx]
				var next_idx = len(user_answers)
				highlight_button_animation(actual_answers[next_idx])
			else:
				user_answers = []
				highlight_button_animation(actual_answers[0])

func correct_so_far():
	for i in range(len(user_answers)):
		if user_answers[i] != actual_answers[i]:
			return false
	return true

func _on_back() -> void:
	get_tree().change_scene_to_file(back_scene)

func _on_solve() -> void:
	get_tree().change_scene_to_file(next_scene)
