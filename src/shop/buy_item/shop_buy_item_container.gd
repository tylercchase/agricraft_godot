extends Container


var item_to_purchase: InventoryItem

@export var price_per = 5

@onready var purchase_1_button = %Purchase1Button


func _ready() -> void:
    PlayerStats.currency_changed.connect(_on_currency_changed)
    # check_if_buyable(PlayerStats.currency)
    update_buttons(PlayerStats.currency)
    purchase_1_button.pressed.connect(_on_purchase_button.bind(1))

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
