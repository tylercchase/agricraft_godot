
class_name BuyUpgradeButton
extends PanelContainer

enum Type {
    STAT,
    MECHANIC
}

@export var type: Type
@export var max_buy: int = 1
@export var upgrade_name: String
@export var id: String
@export var prices: Array[int]

@export_multiline var description: String


@export_category("internal")
@export var name_label: Label
@export var description_label: RichTextLabel
@export var upgrade_button: Button


var current_upgrade_level = 0

func _ready() -> void:
    name_label.text = upgrade_name + ' lvl ' +str(current_upgrade_level + 1)
    description_label.text = description
    upgrade_button.disabled = true
    update_buttons(PlayerStats.currency)
    PlayerStats.currency_changed.connect(_on_currency_changed)
    upgrade_button.pressed.connect(_on_purchase_button)


func _on_purchase_button():
    purchase_item()

func purchase_item():
    PlayerStats.currency = clamp(PlayerStats.currency - prices[current_upgrade_level], 0, INF)
    # Events.emit_buy_item(item_to_purchase, amount)
    handle_upgrades(id)
    current_upgrade_level += 1
    update_buttons(PlayerStats.currency)

func update_buttons(current_funds):
    upgrade_button.disabled = !check_if_buyable(current_funds)
    if upgrade_button.disabled: # make this grab a list of all buttons later, this works for now
        upgrade_button.tooltip_text = 'Not enough moneys'
    if current_upgrade_level < len(prices):
        upgrade_button.text = 'Buy ' + str(prices[current_upgrade_level]) + 'g'
    else:
        upgrade_button.text = 'Max level'
    name_label.text = upgrade_name + ' lvl ' +str(current_upgrade_level + 1)
    
    

func check_if_buyable(current_funds):
    return current_upgrade_level < len(prices) && current_funds >= prices[current_upgrade_level]


func _on_currency_changed(current_funds):
    update_buttons(current_funds)


func handle_upgrades(id: String):
    # this is gonna be super gross, but last minute coding ftw
    Events.emit_sound_event('shop_buy')
    if id == 'mutation':
        PlayerStats.global_mutation *= 1.05
        pass
    elif id == 'speed':
        PlayerStats.global_mutation *= 1.05