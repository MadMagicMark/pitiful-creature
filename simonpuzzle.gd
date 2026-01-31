extends Control

@export var button_container: Control
@export var back_scene: String = "res://level1.tscn"
@export var actual_answers: Array[int] = [
	1, 7, 11, 4, 
]
@export var blue_mask_mode:bool
@export var highlight_anim_time = 0.5
var user_answers: Array[int] = []

func _ready() -> void:
	var idx: int = 0
	for child_button in button_container.get_children():
		child_button.pressed.connect(_on_button_pressed.bind(idx))
		idx += 1
	if blue_mask_mode:
		highlight_button_animation(actual_answers[0])
		
func highlight_button_animation(idx: int):
	var btn = button_container.get_children()[idx]
	btn.modulate = Color(1.0, 1.0, 0.0)
	var tween = get_tree().create_tween()
	tween.tween_interval(highlight_anim_time)
	tween.connect("finished", reset_button_highlight.bind(idx))

func reset_button_highlight(idx: int):
	var btn = button_container.get_children()[idx]
	btn.modulate = Color(1.0, 1.0, 1.0)

func _on_button_pressed(idx: int) -> void:
	if idx == 0:
		_on_back()
	else:
		user_answers.append(idx)
		if user_answers == actual_answers:
			_on_solve()
		else:
			if correct_so_far():
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
	get_tree().change_scene_to_file(back_scene)
