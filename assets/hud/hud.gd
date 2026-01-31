extends CanvasLayer

@export var mask_container: Control;
@export var selected_mask_idx:int = 0:
    set(value):
        selected_mask_idx = value
        _update_selected_mask()
@export var collected_mask_cnt:int = 0:
    set(value):
        collected_mask_cnt = value
        _update_collected_masks()

func _update_selected_mask():
    var idx:int = 0
    for mask_texture_rect in mask_container.get_children():
        var selected_texture = mask_texture_rect.get_child(0)
        selected_texture.visible = idx == selected_mask_idx
        idx += 1

func _update_collected_masks():
    var idx:int = 0
    for mask_texture_rect in mask_container.get_children():
        mask_texture_rect.visible = idx <= collected_mask_cnt
        idx += 1
    