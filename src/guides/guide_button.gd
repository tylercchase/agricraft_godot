extends Button

@export var id: String

func _ready() -> void:
    pressed.connect(Events.emit_guide_open.bind(id))
