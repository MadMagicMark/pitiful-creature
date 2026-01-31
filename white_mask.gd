extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Item collected!")
		# get_parent().queue_free()  # Removes the parent Sprite2D
