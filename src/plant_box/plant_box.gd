
class_name PlantBox
extends Button


var plant_resource: Plant = null
var current_progress = 0

func _ready():
	pass

func update_progress():
	current_progress += plant_resource.genetics.speed * 10
	set_progress(current_progress)

func set_progress(value: float):
	$ProgressBar.value = value

func has_plant() -> bool:
	return plant_resource != null

func setup_plant(plant: Plant):
	plant_resource = plant

func remove_plant():
	plant_resource = null
