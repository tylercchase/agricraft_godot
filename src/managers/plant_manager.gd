
class_name PlantManager
extends Node

@export var plant_grid_container: PlantGridContainer
@export var inventory_manager: InventoryManager

func plant_crop(plant: Plant, box_id):
    var box = plant_grid_container.get_box(box_id)
    if !box.is_occupied():
        box.setup_plant(plant)

func harvest_crop(box_id):
    var box: PlantBox = plant_grid_container.get_box(box_id)
    if box.harvestable:
        inventory_manager.add_item(box.plant_resource.output, box.plant_resource.dominant_gene.bounty)
        remove_crop(box_id)

func remove_crop(box_id):
    var box: PlantBox = plant_grid_container.get_box(box_id)
    if box.plant_resource:
        inventory_manager.add_item(box.plant_resource) # add the seed
        box.remove_plant()
    Events.emit_tooltip_change(Tooltip.Type.NONE, null)
    

func clear_space(box_id):
    var box: PlantBox = plant_grid_container.get_box(box_id)
    if box.plant_resource:
        inventory_manager.add_item(box.plant_resource) # add the seed
        box.remove_plant()
    else:
        box.clear_spot()

func speed_up(box_id):
    var box: PlantBox = plant_grid_container.get_box(box_id)
    box.speed_up()
    pass

func setup_trellis(box_id):
    var box: PlantBox = plant_grid_container.get_box(box_id)
    if !box.is_occupied():
        box.add_trellis()
