extends Node

signal interaction_mode_changed

signal square_clicked

signal set_selected_item # this might become less of a thing when starting to use drag and drop but works for now

signal tooltip_change

signal buy_item

func emit_interaction_mode_changed(mode):
    interaction_mode_changed.emit(mode)

func emit_square_clicked(id, mouse: MouseButton):
    square_clicked.emit(id, mouse)

func emit_selected_item(item: InventoryManager.ItemSlot):
    set_selected_item.emit(item)

func emit_tooltip_change(type: Tooltip.Type, data):
    tooltip_change.emit(type, data)

func emit_buy_item(item: Resource, amount: int):
    buy_item.emit(item, amount)