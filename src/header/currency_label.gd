extends Label

func _ready() -> void:
    PlayerStats.currency_changed.connect(_on_currency_changed)
    update_label(PlayerStats.currency)

func update_label(current_currency):
    text = 'Currency: ' + str(current_currency)


func _on_currency_changed(current_currency):
    update_label(current_currency)