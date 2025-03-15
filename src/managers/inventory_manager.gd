
class_name InventoryManager
extends Node


signal inventory_changed

class ItemSlot extends Resource:
    var id
    var item
    var amount = 1

var items: Array[ItemSlot] = []

func add_item(item):
    var item_slot = ItemSlot.new()
    item_slot.item = item
    item_slot.id = item_slot.get_rid()
    items.push_back(item_slot)
    inventory_changed.emit(items)

func find_id(item: ItemSlot, id):
    return item.id == id

func remove_item(item_id, amount):
    var index = items.find_custom(find_id.bind(item_id))
    items[index].amount -= 1
    if items[index].amount <= 0:
        items.remove_at(index)
    inventory_changed.emit(items)
