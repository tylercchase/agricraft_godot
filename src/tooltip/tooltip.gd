
class_name Tooltip
extends Control

var offset = Vector2(5,5)
var padding = Vector2i(100,50)

enum Type {
    PLANT,
    ITEM,
    NONE
}

@export var plant_tooltip_scene: PackedScene
@export var item_tooltip_scene: PackedScene # not made yet
func _ready() -> void:
    visible = false
    Events.tooltip_change.connect(_on_tooltip_change)


func _process(_delta: float) -> void:
    # yoinked code from https://github.com/IndieQuest/Modular-tooltip/blob/master/Tooltip.gd
    # can be better probs but I really don't want to look at this yet
    if !visible:
        return
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

func remove_current():
    for child in get_children():
        child.queue_free()

func _on_tooltip_change(type: Type, data):
    remove_current()

    if type == Type.PLANT:
        visible = true
        var plant_tooltip = plant_tooltip_scene.instantiate()
        add_child(plant_tooltip)
        plant_tooltip.setup(data)
    elif type == Type.ITEM:
        visible = true
        var item_tooltip = item_tooltip_scene.instantiate()
        add_child(item_tooltip)
        item_tooltip.position = Vector2(0,0) # TODO: for some reason the tooltip keeps getting set to way far away, this fixes for now
        item_tooltip.setup(data)
    elif type == Type.NONE:
        visible = false
