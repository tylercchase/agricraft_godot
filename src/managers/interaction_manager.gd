
class_name InteractionManager
extends Node

@export var plant_grid_container: PlantGridContainer
@export var plant_manager: PlantManager
@export var inventory_manager: InventoryManager

@export var mutation_button: Button
@export var clear_button: Button

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
    mutation_button.pressed.connect(toggle_mode.bind(Mode.TRELLIS))
    clear_button.pressed.connect(toggle_mode.bind(Mode.REMOVE))

func toggle_mode(mode: Mode):
    if mode == current_mode:
        Events.emit_interaction_mode_changed(Mode.NONE)
    else:
        Events.emit_interaction_mode_changed(mode)

func set_active_item(selected: InventoryManager.ItemSlot):
    selected_item = selected
    if selected:
        current_mode = Mode.NONE
        mutation_button.button_pressed = false
        clear_button.button_pressed = false


func _on_interaction_mode_changed(mode: Mode):
    if selected_item && current_mode != mode:
        Events.emit_set_selected_item(null)
    if mode == Mode.REMOVE:
        clear_button.button_pressed = true
        mutation_button.button_pressed = false
    if mode == Mode.TRELLIS:
        mutation_button.button_pressed = true
        clear_button.button_pressed = false
    current_mode = mode
    # bad way, but works for now
    # hopefully won't have more interactions


func _on_square_clicked(id):
    print(current_mode)
    if selected_item:
        if selected_item.item is Plant && !plant_grid_container.boxes[id].is_occupied():
            plant_manager.plant_crop(selected_item.item, id)
            inventory_manager.remove_item(selected_item.id, 1)
        else:
            # just to avoid clicking and _nothing_ happening on a square
            # eventually change so there's more handling of stuff
            # right now it's just too hard to tell what's going on
            Events.emit_selected_item(null)
            plant_manager.harvest_crop(id)
    elif current_mode == Mode.TRELLIS:
        print('doing thing')
        plant_manager.setup_trellis(id)
    elif current_mode == Mode.REMOVE:
        plant_manager.clear_space(id)
    else:
        plant_manager.harvest_crop(id)
    #trellis code later, needs some work

    # if current_mode == Mode.PLANT:
    #     plant_manager.plant_crop(load("res://src/plant/resources/wheat.tres"), id)
    # elif current_mode == Mode.TRELLIS:
    #     plant_manager.setup_trellis(id)
    # elif current_mode == Mode.REMOVE:
    #     plant_manager.clear_space(id)