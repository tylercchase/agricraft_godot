extends PanelContainer


@onready var plant_button: Button = %PlantButton
@onready var remove_button: Button = %RemoveButton
@onready var trellis_button: Button = %TrellisButton


var current_mode: InteractionManager.Mode = InteractionManager.Mode.NONE


func _ready() -> void:
	plant_button.pressed.connect(set_interaction_mode.bind(InteractionManager.Mode.PLANT))
	remove_button.pressed.connect(set_interaction_mode.bind(InteractionManager.Mode.REMOVE))
	trellis_button.pressed.connect(set_interaction_mode.bind(InteractionManager.Mode.TRELLIS))
	var group = ButtonGroup.new()
	group.allow_unpress = true
	for button in [plant_button, remove_button, trellis_button]:
		button.button_group = group


func set_interaction_mode(mode):
	if current_mode == mode:
		current_mode = InteractionManager.Mode.NONE
	else:
		current_mode = mode
	Events.emit_interaction_mode_changed(current_mode)
