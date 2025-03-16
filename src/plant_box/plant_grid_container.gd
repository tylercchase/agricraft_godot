
class_name PlantGridContainer
extends GridContainer

@export var width = 7
@export var height = 7

var boxes: Array[PlantBox] = []

func _ready() -> void:
    var temp_boxes = get_children()
    for i in len(temp_boxes):
        boxes.append(temp_boxes[i] as PlantBox)
        boxes[i].pressed.connect(_on_box_pressed.bind(i))
        boxes[i].id = i

func _on_box_pressed(id):
    Events.emit_square_clicked(id)

func get_box(id) -> PlantBox :
    return boxes[id]

func get_box_offset(id, x_offset, y_offset):
    var current_x = id / width
    var current_y = (id % height)
    var new_x = current_x + x_offset
    var new_y = current_y + y_offset
    if new_x < 0 || new_x > height - 1:
        if new_y < 0 || new_y > width - 1:
            return null
    return boxes[new_x * width + new_y]