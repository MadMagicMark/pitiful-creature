extends Area2D

const PORTAL_NAME = "portal"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.player_enter_area(PORTAL_NAME)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.player_leave_area(PORTAL_NAME)
