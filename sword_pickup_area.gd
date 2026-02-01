extends Area2D

var SWORD_AREA = 'sword'

@export var sword_sprite:Sprite2D

func _ready():
    body_entered.connect(_on_body_entered)
    body_exited.connect(_on_body_exited)
    if GameManager.has_mask(GameManager.MASK_3):
        get_parent().queue_free()

func can_pickup() -> bool:
    return GameManager.current_mask_name == GameManager.MASK_3

func _on_body_entered(body):
    if body.is_in_group("player"):
        GameManager.player_enter_area(SWORD_AREA)

func _on_body_exited(body):
    if body.is_in_group("player"):
        GameManager.player_leave_area(SWORD_AREA)

func _input(event: InputEvent) -> void:
    if event is InputEventKey and event.pressed:
        var keycode = event.keycode
        if keycode == KEY_E:
            if GameManager.player_in_area("sword"):
                if can_pickup():
                    print("TOdo udpate GM")
                    sword_sprite.queue_free()
                else:
                    print("no sword for you")
