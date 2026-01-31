extends CanvasLayer

@export var mask_container: Control;

func collect_mask(mask_idx: int):
	for child in mask_container.get_children():
		if child.get_meta("mask_idx") == mask_idx:
			child.visible = true

func select_mask(mask_idx: int):
	for child in mask_container.get_children():
		if child.get_meta("mask_idx") == mask_idx:
			child.modulate = Color(1.2, 1.2, 1.2)
		else:
			child.modulate = Color(1.0, 1.0, 1.0)
