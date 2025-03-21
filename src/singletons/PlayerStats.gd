extends Node


signal currency_changed
var currency = 0:
        get:
            return currency
        set(value):
            currency_changed.emit(currency)
            currency = value

