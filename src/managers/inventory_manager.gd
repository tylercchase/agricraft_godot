
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
    if item is Plant: # it's a seed
        print('test')
        item_slot.id = item.id + item.dominant_gene.to_string() + '-' + item.recessive_gene.to_string() # possibly use a combo of genetic stuff for this, add a to string function to genomes?
    elif item is InventoryItem:
        item_slot.id = item.id
    else:
        item_slot.id = item # it's a string just use it raw
        # eventually this should probably use a resource for items, but for now it's fineeee
    print(item_slot.id)
    var check_index = items.find_custom(find_id.bind(item_slot.id))
    if check_index >= 0:
        items[check_index].amount += 1
    else:
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
