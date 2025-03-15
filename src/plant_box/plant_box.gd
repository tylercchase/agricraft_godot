
class_name PlantBox
extends Button


var plant_resource: Plant = null
var current_progress = 0

var harvestable = false

@onready var label: Label = %Label
@onready var progress_bar: ProgressBar = %ProgressBar


func update_progress():
    if harvestable:
        return
    current_progress += plant_resource.genetics.speed * 25
    set_progress(current_progress)
    if current_progress >= 100:
        set_ready_for_harvest()

func set_progress(value: float):
    progress_bar.value = value

func has_plant() -> bool:
    return plant_resource != null

func setup_plant(plant: Plant):
    plant_resource = plant
    label.text = plant.display_character

func remove_plant():
    plant_resource = null
    label.text = ''
    label.modulate = Color.WHITE
    progress_bar.value = 0

func set_ready_for_harvest():
    print('ready!')
    harvestable = true
    label.modulate = Color.LIME_GREEN
