extends PanelContainer

@export var close_button: Button
@export var id: String
func _ready() -> void:
    Events.guide_open.connect(_on_guide_open)
    close_button.pressed.connect(Events.emit_guide_open.bind(''))

func _on_guide_open(request_id: String):
    print(request_id)
    print('test')
    if request_id == id:
        visible = true
    else:
        visible = false