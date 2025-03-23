extends ProgressBar

@export var item_id: String
@export var total_to_collect: int

var current_collected = 0

func _ready() -> void:
    Events.item_collected.connect(_on_item_collected)


func update_progress():
    value = float(current_collected) / float(total_to_collect)

func process_item(item: String, count: int):
    if item == item_id:
        current_collected += count
        update_progress()

func _on_item_collected(item: String, count: int):
    process_item(item, count)