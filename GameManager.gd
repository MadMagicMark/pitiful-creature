extends Node

var current_level: int = 1
var masks_collected: Dictionary = {}

const MASK_1: String = "MASK-1"
const MASK_2: String = "MASK-2"
const MASK_3: String = "MASK-3"
const MASK_4: String = "MASK-4"

var current_mask_name: String = MASK_1
const MASK_NAMES = [MASK_1, MASK_2, MASK_3, MASK_4 ]

func _ready() -> void:
	# print("Initializing GameManager")
	for i in range(len(MASK_NAMES)):
		masks_collected[MASK_NAMES[i]] = false
	masks_collected[MASK_NAMES[0]] = true

func wear_mask(mask_id) -> void:
	current_mask_name = mask_id

func acquire_mask(mask_id) -> void:
	masks_collected[mask_id] = true
	wear_mask(mask_id)

func has_mask(mask_id) -> bool:
	return masks_collected[mask_id]

#func change_level(level_path: String):
	#get_tree().change_scene_to_file(level_path)

func reset_game():
	current_level = 1
