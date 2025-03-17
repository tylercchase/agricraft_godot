extends Container


@onready var plant_button: Button = %PlantButton
@onready var remove_button: Button = %RemoveButton
@onready var trellis_button: Button = %TrellisButton

@onready var inventory_container: InventoryContainer = %InventoryContainer

@export var inventory_manager: InventoryManager



var current_mode: InteractionManager.Mode = InteractionManager.Mode.NONE


func _ready() -> void:
    plant_button.pressed.connect(set_interaction_mode.bind(InteractionManager.Mode.PLANT))
    remove_button.pressed.connect(set_interaction_mode.bind(InteractionManager.Mode.REMOVE))
    trellis_button.pressed.connect(set_interaction_mode.bind(InteractionManager.Mode.TRELLIS))
    var group = ButtonGroup.new()
    group.allow_unpress = true
    for button in [plant_button, remove_button, trellis_button]:
        button.button_group = group
    inventory_manager.inventory_changed.connect(_on_inventory_changed)


func set_interaction_mode(mode):
    if current_mode == mode:
        current_mode = InteractionManager.Mode.NONE
    else:
        current_mode = mode
    Events.emit_interaction_mode_changed(current_mode)


func _on_inventory_changed(items: Array[InventoryManager.ItemSlot]):
    print(items)
    inventory_container.update_items(items)