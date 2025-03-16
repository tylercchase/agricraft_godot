
class_name InventoryContainer
extends Container

@export var slot_scene: PackedScene

@onready var container: Container = $HBoxContainer


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
            scene.text = item.item.name
        else:
            scene.text = str(item.item) + str(item.amount)
