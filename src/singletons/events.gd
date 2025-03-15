extends Node

signal interaction_mode_changed

signal square_clicked

func emit_interaction_mode_changed(mode):
    interaction_mode_changed.emit(mode)

func emit_square_clicked(id):
    square_clicked.emit(id)