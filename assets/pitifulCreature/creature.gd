extends CharacterBody2D

@export var sprite:Sprite2D
@export var animationPlayer:AnimationPlayer

func _ready() -> void:
	# $AnimationPlayer.play("player_idle")
	animationPlayer.play("player_idle")
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = GameManager.playerStats["jump_velocity"]

	# Check for horizontal motion
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		# Player started moving horizontally
		velocity.x = direction * GameManager.playerStats["speed"]
		animationPlayer.play("player_walk")
		
		# Figure out which direction the sprite should face
		if velocity.x < 0.0:
			sprite.flip_h = true
		
		if velocity.x > 0.0:
			sprite.flip_h = false
	else:
		# Player has stopped moving horizontally
		velocity.x = move_toward(velocity.x, 0, GameManager.playerStats["speed"])
		animationPlayer.play("player_idle")
	
	move_and_slide()
