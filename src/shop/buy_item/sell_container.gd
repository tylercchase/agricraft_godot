extends PanelContainer

var selected_item: InventoryManager.ItemSlot

@export var sell_one_button: Button
@export var sell_half_button: Button
@export var sell_all_button: Button

@export var name_label: Label
@export var price_label: Label

@export var inventory_manager: InventoryManager

enum Modifier {
    ONE,
    HALF,
    ALL
}

func _ready() -> void:
    Events.set_selected_item.connect(_on_set_selected_item)
    sell_one_button.pressed.connect(_on_sell_button_clicked.bind(Modifier.ONE))
    sell_half_button.pressed.connect(_on_sell_button_clicked.bind(Modifier.HALF))
    sell_all_button.pressed.connect(_on_sell_button_clicked.bind(Modifier.ALL))
    update_menu()


func update_menu():
    var disabled = selected_item == null || !selected_item.item.get('base_sell_price')
    sell_one_button.disabled = disabled
    sell_half_button.disabled = disabled
    sell_all_button.disabled = disabled
    if selected_item != null:
        pass
        name_label.text = selected_item.item.name
        if selected_item.item.get('base_sell_price'):
            price_label.text = str(selected_item.item.base_sell_price) + ' g'
        else:
            price_label.text = 'N/A'
    else:
        name_label.text = ''
        price_label.text = ''


func sell_item(modifier: Modifier):
    var amount_to_sell
    match modifier:
        Modifier.ONE:
            amount_to_sell = 1
        Modifier.HALF:
            amount_to_sell = selected_item.amount / 2
        Modifier.ALL:
            amount_to_sell = selected_item.amount
    PlayerStats.currency += selected_item.item.base_sell_price * amount_to_sell
    inventory_manager.remove_item(selected_item.item.id, amount_to_sell)

func _on_set_selected_item(new_selected_item):
    if new_selected_item != null && new_selected_item is InventoryManager.ItemSlot:
        selected_item = new_selected_item
    else:
        selected_item = null
    update_menu()


func _on_sell_button_clicked(modifier: Modifier):
    sell_item(modifier)