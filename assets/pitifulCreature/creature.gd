extends CharacterBody2D

var sprite:Sprite2D
var animationPlayer: AnimationPlayer
var sprite2:Sprite2D
var animationPlayer2: AnimationPlayer
var sprite3:Sprite2D
var animationPlayer3: AnimationPlayer
var sprite4:Sprite2D
var animationPlayer4: AnimationPlayer
var collisionShape: CollisionShape2D
var collisionShape2: CollisionShape2D
var collisionShape3: CollisionShape2D
var collisionShape4: CollisionShape2D


func _ready() -> void:
	GameManager.inventory_changed.connect(_on_inventory_changed)

	sprite = $PlayerSprite
	sprite2 = $PlayerSprite2
	sprite3 = $PlayerSprite3
	sprite4 = $PlayerSprite4
	animationPlayer = $PlayerSprite/AnimationPlayer
	animationPlayer2 = $PlayerSprite2/AnimationPlayer
	animationPlayer3 = $PlayerSprite3/AnimationPlayer
	animationPlayer4 = $PlayerSprite4/AnimationPlayer
	collisionShape = $CollisionShape2D
	collisionShape2 = $CollisionShape2D2
	collisionShape3 = $CollisionShape2D3
	collisionShape4 = $CollisionShape2D4

	animationPlayer.play("player_idle")
	animationPlayer2.play("idle")
	animationPlayer3.play("idle")

	show_visible_player_version()

func _on_inventory_changed(mask_id) -> void:
	show_visible_player_version()
	update_collision_shape()

func show_visible_player_version():
	sprite.visible = GameManager.current_mask_name == GameManager.NO_MASK
	collisionShape.disabled = GameManager.current_mask_name != GameManager.NO_MASK
	sprite2.visible = GameManager.current_mask_name == GameManager.MASK_DAPPER
	collisionShape2.disabled = GameManager.current_mask_name != GameManager.MASK_DAPPER
	sprite3.visible = GameManager.current_mask_name == GameManager.MASK_2
	collisionShape3.disabled = GameManager.current_mask_name != GameManager.MASK_2
	sprite4.visible = GameManager.current_mask_name == GameManager.MASK_3
	collisionShape4.disabled = GameManager.current_mask_name != GameManager.MASK_3	

func update_collision_shape():
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = GameManager.playerStats[GameManager.current_mask_name]["jump_velocity"]

	# Check for horizontal motion
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		# Player started moving horizontally
		velocity.x = direction * GameManager.playerStats[GameManager.current_mask_name]["speed"]
		animationPlayer.play("player_walk")
		animationPlayer2.play("walk")
		animationPlayer3.play("walk")
		animationPlayer4.play("walk")
		
		# Figure out which direction the sprite should face
		if velocity.x < 0.0:
			sprite.flip_h = true
			sprite2.flip_h = true
			sprite3.flip_h = true
			sprite4.flip_h = true
		
		if velocity.x > 0.0:
			sprite.flip_h = false
			sprite2.flip_h = false
			sprite3.flip_h = false
			sprite4.flip_h = false
	else:
		# Player has stopped moving horizontally
		velocity.x = move_toward(velocity.x, 0, GameManager.playerStats[GameManager.current_mask_name]["speed"])
		animationPlayer.play("player_idle")
		animationPlayer2.play("idle")
		animationPlayer3.play("idle")
		animationPlayer4.play("idle")
	
	move_and_slide()
