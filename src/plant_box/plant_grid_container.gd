
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

func _on_box_pressed(id):
    Events.emit_square_clicked(id)

func get_box(id) -> PlantBox :
    return boxes[id]

func get_box_offset(id, x_offset, y_offset):
    pass