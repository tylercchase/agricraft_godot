extends Control

func _ready() -> void:
    for child in get_children():
        child.visible = false