extends CanvasLayer

@export var mask_container: Control;


func update_mask_ui():
	show_collected_masks()
	show_selected_mask()

func show_collected_masks() -> void:
	for child in mask_container.get_children():
		var mask_name = child.get_meta("mask_name")
		if GameManager.masks_collected[mask_name]:
			child.visible = true

func show_selected_mask() -> void:
	for child in mask_container.get_children():
		if child.get_meta("mask_name") == GameManager.current_mask_name:
			child.modulate = Color(1.2, 1.2, 1.2)
		else:
			child.modulate = Color(1.0, 1.0, 1.0)
