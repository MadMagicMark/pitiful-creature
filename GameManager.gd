extends Node

# Game State

var current_level: int = 1
var masks_collected: Dictionary = {}

const NO_MASK: String = "NO_MASK"
const MASK_DAPPER: String = "MASK_DAPPER"
const MASK_2: String = "MASK_2"
const MASK_3: String = "MASK_3"
const MASK_4: String = "MASK_4"

var player_in_areas: Array[String] = []

var current_mask_name: String = NO_MASK
const MASK_NAMES = [ NO_MASK, MASK_DAPPER, MASK_2, MASK_3, MASK_4 ]

var playerStats = {
	NO_MASK: {
		"jump_velocity": -150.0,
		"speed": 75.0,
	},
	# White Mask
	MASK_DAPPER: {
		"jump_velocity": -550.0,
		"speed": 200.0,
	},
	# Blue Mask
	MASK_2: {
		"jump_velocity": -250.0,
		"speed": 120.0,
	},
	# Green
	MASK_3: {
		"jump_velocity": -250.0,
		"speed": 120.0,
	},
	# Yellow
	MASK_4: {
		"jump_velocity": -200.0,
		"speed": 200.0,
	},	
}

# Game state signals
signal inventory_changed(item_name)
signal player_in_group_changed()

func _ready() -> void:
	# print("Initializing GameManager")
	for i in range(len(MASK_NAMES)):
		masks_collected[MASK_NAMES[i]] = false
	masks_collected[MASK_NAMES[0]] = true

func wear_mask(mask_id) -> void:
	if not masks_collected[mask_id]:
		# Prevent users from wearing masks they haven't collected
		return

	current_mask_name = mask_id
	inventory_changed.emit(mask_id)

func acquire_mask(mask_id) -> void:
	masks_collected[mask_id] = true
	wear_mask(mask_id)
	inventory_changed.emit(mask_id)
	play_sound("pickup")

func has_mask(mask_id) -> bool:
	return masks_collected[mask_id]

func player_enter_area(area_name: String) -> void:
	if not area_name in player_in_areas:
		player_in_areas.append(area_name)
		player_in_group_changed.emit()

func player_leave_area(area_name: String) -> void:
	if area_name in player_in_areas:
		player_in_areas.erase(area_name)
		player_in_group_changed.emit()

func player_in_area(area_name: String) -> bool:
	return player_in_areas.has(area_name)

#func change_level(level_path: String):
	#get_tree().change_scene_to_file(level_path)

func reset_game():
	current_level = 1


#
# Sound Effects

@onready var bg_music = preload("res://assets/music/pitiful creature music.wav")

func start_music() -> void:
	print("Music should start here")
	var bgplayer = AudioStreamPlayer.new()
	bgplayer.stream = bg_music
	
	bgplayer.volume_linear *= 0.3
	
	add_child(bgplayer)
	bgplayer.play()
	
	while 1:
		await bgplayer.finished
		bgplayer.play()
	
@onready var pickup_sound = preload("res://assets/sounds/cheap-bell-chime.wav")

# Play sound -- call this with the name of the sound to play
func play_sound(sound_name: String):
	var player = AudioStreamPlayer.new()

	# Select the sound here	
	if (sound_name == "pickup"):
		player.stream = pickup_sound

	add_child(player)
	player.play()
	await player.finished
	player.queue_free()
