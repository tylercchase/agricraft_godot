
class_name PlantManager
extends Node

@export var plant_grid_container: PlantGridContainer

func plant_crop(plant: Plant, box_id):
    var box = plant_grid_container.get_box(box_id)
    box.setup_plant(plant)
