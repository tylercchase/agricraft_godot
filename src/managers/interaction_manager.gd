
class_name InteractionManager
extends Node

@export var plant_grid_container: PlantGridContainer
@export var plant_manager: PlantManager


enum Mode {
	NONE,
	PLANT,
	REMOVE,
	TRELLIS,
}

var current_mode: Mode = Mode.NONE

func _ready() -> void:
    Events.interaction_mode_changed.connect(_on_interaction_mode_changed)
    Events.square_clicked.connect(_on_square_clicked)


func _on_interaction_mode_changed(mode: Mode):
    current_mode = mode

func _on_square_clicked(id):
    if current_mode == Mode.PLANT:
        plant_manager.plant_crop(load("res://src/plant/resources/wheat.tres"), id)
    elif current_mode == Mode.NONE:
        plant_manager.harvest_crop(id)
    elif current_mode == Mode.REMOVE:
        plant_manager.remove_crop(id)