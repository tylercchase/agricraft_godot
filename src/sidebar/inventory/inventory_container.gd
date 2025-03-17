
class_name InventoryContainer
extends Container

@export var slot_scene: PackedScene

@onready var container: Container = self


func _ready() -> void:
    for child in container.get_children():
        child.queue_free()

func update_items(items: Array[InventoryManager.ItemSlot]):
    print(items)
	# just make a whole new thing, can be optimized in the future
	# works for now tho
    for child in container.get_children():
        child.queue_free()

    for item in items:
        var scene : Button = slot_scene.instantiate()
        container.add_child(scene)
        if item.item is Plant:
            scene.text = item.item.name + " " + str(item.amount)
            scene.mouse_entered.connect(Events.emit_tooltip_change.bind(Tooltip.Type.PLANT, item.item))
        elif item.item is InventoryItem:
            scene.text = item.item.name + " " + str(item.amount) # have a better way of displaying count of items
            scene.mouse_entered.connect(Events.emit_tooltip_change.bind(Tooltip.Type.ITEM, item.item))
        else:
            scene.text = str(item.item) + " " + str(item.amount)
        scene.mouse_exited.connect(Events.emit_tooltip_change.bind(Tooltip.Type.NONE, null))