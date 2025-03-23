
class_name InventoryContainer
extends Container

@export var slot_scene: PackedScene

@onready var container: Container = self
@export var inventory_manager: InventoryManager

var selected_item: InventoryManager.ItemSlot

func _ready() -> void:
    for child in container.get_children():
        child.queue_free()
    Events.set_selected_item.connect(_on_selected_item)
    inventory_manager.inventory_changed.connect(update_items)

var items_cached
func _on_selected_item(item):
    selected_item = item
    update_items(items_cached)

func update_items(items: Array[InventoryManager.ItemSlot]):
	# just make a whole new thing, can be optimized in the future
	# works for now tho
    for child in container.get_children():
        child.queue_free()
    items_cached = items
    for item in items:
        var scene : Button = slot_scene.instantiate()
        container.add_child(scene)
        if item.item is Plant:
            scene.text = item.item.display_character 
            scene.mouse_entered.connect(Events.emit_tooltip_change.bind(Tooltip.Type.PLANT, item.item))
        elif item.item is InventoryItem:
            scene.text = item.item.display_character # have a better way of displaying count of items
            scene.mouse_entered.connect(Events.emit_tooltip_change.bind(Tooltip.Type.ITEM, item.item))
        else:
            scene.text = str(item.item)
        scene.mouse_exited.connect(Events.emit_tooltip_change.bind(Tooltip.Type.NONE, null))
        scene.pressed.connect(_on_item_pressed.bind(item))
        var selected = selected_item != null && selected_item.id == item.id
        scene.setup(item, selected)


func _on_item_pressed(item):
    if selected_item && item.id == selected_item.id:
        Events.emit_selected_item(null)
    else:
        Events.emit_selected_item(item)