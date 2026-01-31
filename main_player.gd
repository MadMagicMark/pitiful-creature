extends Sprite2D

var is_idle:bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("player_idle")
	pass # Replace with function body.

func _ensure_walking() -> void:
	if is_idle:
		$AnimationPlayer.play("player_walk")
		is_idle = false

func _process(delta: float) -> void:
	var velocity = Vector2(0.0, 0.0)
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -200.0
		flip_h = true
		_ensure_walking()

	elif Input.is_action_pressed("ui_right"):
		velocity.x = 200.0
		flip_h = false
		_ensure_walking()

	elif Input.is_action_pressed("ui_down"):
		velocity.y = 200.0
		_ensure_walking()
	
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -200.0
		_ensure_walking()

	else:
		# No keys pressed
		if not is_idle:
			$AnimationPlayer.play("player_idle")
			is_idle = true
			velocity = Vector2(0.0, 0.0)
	
	position += delta * velocity

	
