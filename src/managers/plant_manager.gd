
class_name PlantManager
extends Node

@export var plant_grid_container: PlantGridContainer
@export var inventory_manager: InventoryManager

func plant_crop(plant: Plant, box_id):
    var box = plant_grid_container.get_box(box_id)
    if !box.plant_resource:
        box.setup_plant(plant)

func harvest_crop(box_id):
    var box: PlantBox = plant_grid_container.get_box(box_id)
    if box.harvestable:
        inventory_manager.add_item(box.plant_resource.output)
    remove_crop(box_id)

func remove_crop(box_id):
    var box: PlantBox = plant_grid_container.get_box(box_id)
    if box.plant_resource:
        inventory_manager.add_item(box.plant_resource) # add the seed
        box.remove_plant()