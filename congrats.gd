extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	GameManager.win.connect(_on_win)

func _on_win() -> void:
	print("You Won!")
	visible = true
