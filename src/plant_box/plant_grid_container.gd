extends GridContainer

@export var width = 7
@export var height = 7

var boxes: Array[PlantBox] = []

func _ready() -> void:
    var temp_boxes = get_children()
    for i in len(temp_boxes):
        boxes.append(temp_boxes[i] as PlantBox)
		# boxes[i].place_index = i
        boxes[i].pressed.connect(_on_box_pressed.bind(i))
    print(boxes)

func _on_box_pressed(id):
    Events.emit_square_clicked(id)