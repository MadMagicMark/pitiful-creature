extends Control

@export var button_container: Control

@export var back_scene: String = "res://level1.tscn"
@export var actual_answers: Array[int] = [
	1, 7, 11, 4, 
]
var user_answers: Array[int] = []

func _ready() -> void:
	var idx: int = 0
	for child_button in button_container.get_children():
		child_button.pressed.connect(_on_button_pressed.bind(idx))
		idx += 1

func _on_button_pressed(idx: int) -> void:
	if idx == 0:
		_on_back()
	else:
		user_answers.append(idx)
		if user_answers == actual_answers:
			_on_solve()

func _on_back() -> void:
	get_tree().change_scene_to_file(back_scene)

func _on_solve() -> void:
	get_tree().change_scene_to_file(back_scene)
