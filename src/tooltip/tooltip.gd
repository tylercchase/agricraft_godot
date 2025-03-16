
class_name Tooltip
extends Control

var offset = Vector2(5,5)
var padding = Vector2i(100,50)

func _ready() -> void:
    # visible = false
    pass


func _process(delta: float) -> void:
    # yoinked code from https://github.com/IndieQuest/Modular-tooltip/blob/master/Tooltip.gd
    # can be better probs but I really don't want to look at this yet
    var border = get_viewport().size - padding
    var extents = get_rect().size
    var base_position = get_global_mouse_position()

    var final_x = base_position.x + offset.x
    if final_x + extents.x > border.x:
        final_x = base_position.x - offset.x - extents.x
    # test if need to display below
    # var final_y = base_position.y - extents.y - offset.y
    # if final_y < padding.y:
    var final_y = base_position.y + offset.y
    global_position = Vector2(final_x, final_y)

		# var border = get_viewport().size - padding
		# extents = _visuals.rect_size
		# var base_pos = _get_screen_pos()
		# # test if need to display to the left
		# var final_x = base_pos.x + offset.x
		# if final_x + extents.x > border.x:
		# 	final_x = base_pos.x - offset.x - extents.x
		# # test if need to display below
		# var final_y = base_pos.y - extents.y - offset.y
		# if final_y < padding.y:
		# 	final_y = base_pos.y + offset.y
		# _visuals.rect_position = Vector2(final_x, final_y)