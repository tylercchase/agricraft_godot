extends Node


signal currency_changed
var currency = 0:
        get:
            return currency
        set(value):
            currency_changed.emit(value)
            currency = value


var global_mutation = 0.3

var global_speed_mult = 1.0
