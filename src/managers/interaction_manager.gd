
class_name InteractionManager
extends Node


enum Mode {
	NONE,
	PLANT,
	REMOVE,
	TRELLIS,
}

var current_mode: Mode = Mode.NONE

func _ready() -> void:
    Events.interaction_mode_changed.connect(_on_interaction_mode_changed)
    Events.square_clicked.connect(_on_square_clicked)


func _on_interaction_mode_changed(mode: Mode):
    current_mode = mode

func _on_square_clicked(idx):
    print(idx)