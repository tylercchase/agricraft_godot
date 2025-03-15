
class_name PlantGrowthManager
extends Node


@export var plant_grid_container: PlantGridContainer


var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.autostart = false
	add_child(timer)
	timer.start(1)
	timer.timeout.connect(_on_timer_check)


func filter_boxes(box: PlantBox):
	return box.has_plant() # change future to consider more stuff

func _on_timer_check():
	var plants_with_stuff: Array[PlantBox] = plant_grid_container.boxes.filter(filter_boxes)
	for plant_box in plants_with_stuff:
		plant_box.update_progress()
