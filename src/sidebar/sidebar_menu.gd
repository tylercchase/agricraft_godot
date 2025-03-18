extends Container


@onready var inventory_container: InventoryContainer = %InventoryContainer

@export var inventory_manager: InventoryManager



var current_mode: InteractionManager.Mode = InteractionManager.Mode.NONE


func _ready() -> void:
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