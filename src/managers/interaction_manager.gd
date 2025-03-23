
class_name InteractionManager
extends Node

@export var plant_grid_container: PlantGridContainer
@export var plant_manager: PlantManager
@export var inventory_manager: InventoryManager
@export var audio_stream: AudioStreamPlayer

var selected_item: InventoryManager.ItemSlot = null

enum Mode {
	NONE,
	REMOVE,
	TRELLIS,
}

var current_mode: Mode = Mode.NONE

func _ready() -> void:
    Events.interaction_mode_changed.connect(_on_interaction_mode_changed)
    Events.square_clicked.connect(_on_square_clicked)
    Events.set_selected_item.connect(set_active_item)
    # plant_manager.plant_crop(load("res://src/plant/resources/wheat.tres"), id)

func toggle_mode(mode: Mode):
    if mode == current_mode:
        Events.emit_interaction_mode_changed(Mode.NONE)
    else:
        Events.emit_interaction_mode_changed(mode)

func set_active_item(selected: InventoryManager.ItemSlot):
    selected_item = selected
    if selected:
        current_mode = Mode.NONE


func _on_interaction_mode_changed(mode: Mode):
    if selected_item && current_mode != mode:
        Events.emit_set_selected_item(null)
    current_mode = mode
    # bad way, but works for now
    # hopefully won't have more interactions


func _on_square_clicked(id, mouse_button):

    var box = plant_grid_container.boxes[id]
    if mouse_button == MOUSE_BUTTON_LEFT:
        if selected_item:
            if selected_item.item is Plant && !box.is_occupied():
                plant_manager.plant_crop(selected_item.item, id)
                inventory_manager.remove_item(selected_item.id, 1)
            else:
            # just to avoid clicking and _nothing_ happening on a square
            # eventually change so there's more handling of stuff
            # right now it's just too hard to tell what's going on
                Events.emit_selected_item(null)
                plant_manager.harvest_crop(id)
        elif box.harvestable:
            plant_manager.harvest_crop(id)
        elif box.plant_resource:
            plant_manager.speed_up(id)
            pass
    elif !box.is_occupied():
            plant_manager.setup_trellis(id)
    else:
        if box.harvestable: # harvest a removed grown crop
            plant_manager.harvest_crop(id)
        plant_manager.clear_space(id)
    audio_stream.play()
