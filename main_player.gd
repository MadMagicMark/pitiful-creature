extends Sprite2D

var is_idle:bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("player_idle")
	pass # Replace with function body.

func _process(delta: float) -> void:
	var velocity = 0.0
	
	if Input.is_action_pressed("ui_left"):
		velocity = -200.0
		flip_h = true
		if is_idle:
			$AnimationPlayer.play("player_walk")
			is_idle = false
	elif Input.is_action_pressed("ui_right"):
		velocity = 200.0
		flip_h = false
		if is_idle:
			$AnimationPlayer.play("player_walk")
			is_idle = false
	else:
		if not is_idle:
			$AnimationPlayer.play("player_idle")
			is_idle = true

	
	position.x += velocity * delta

	
