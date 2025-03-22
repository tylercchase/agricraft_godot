extends Container




@export var item_to_purchase: Resource
@export var price_per = 1


@export_category('Internal')
@export var name_label: Label
@export var preview_label: Label
@export var preview_container: Container
@export var purchase_1_button: Button


func _ready() -> void:
    PlayerStats.currency_changed.connect(_on_currency_changed)
    update_buttons(PlayerStats.currency)
    purchase_1_button.pressed.connect(_on_purchase_button.bind(1))
    name_label.text = item_to_purchase.name
    preview_label.text = item_to_purchase.display_character
    purchase_1_button.text = 'Buy ' + str(price_per) + 'g'
    var type = Tooltip.Type.PLANT
    if item_to_purchase is InventoryItem:
        type = Tooltip.Type.ITEM
    preview_container.mouse_entered.connect(Events.emit_tooltip_change.bind(type, item_to_purchase))
    preview_container.mouse_exited.connect(Events.emit_tooltip_change.bind(Tooltip.Type.NONE, null))
    update_buttons(PlayerStats.currency)

func _on_purchase_button(amount):
    purchase_item(amount)

func purchase_item(amount):
    PlayerStats.currency = clamp(PlayerStats.currency - amount * price_per, 0, INF)
    Events.emit_buy_item(item_to_purchase, amount)

func update_buttons(current_funds):
    purchase_1_button.disabled = !check_if_buyable(current_funds, 1)
    if purchase_1_button.disabled: # make this grab a list of all buttons later, this works for now
        purchase_1_button.tooltip_text = 'Not enough moneys'

func check_if_buyable(current_funds, amount_to_buy):
    return  current_funds >= amount_to_buy * price_per


func _on_currency_changed(current_funds):
    update_buttons(current_funds)
