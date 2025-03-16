
class_name PlantBox
extends Button


var plant_resource: Plant = null
var current_progress = 0

var harvestable = false

var trellis = false

@onready var label: Label = %Label
@onready var progress_bar: ProgressBar = %ProgressBar
var id

func _ready() -> void:
    mouse_entered.connect(_on_mouse_enter)
    mouse_exited.connect(_on_mouse_exit)


func _on_mouse_enter():
    if plant_resource:
        Events.emit_tooltip_change(Tooltip.Type.PLANT, plant_resource)

func _on_mouse_exit():
    Events.emit_tooltip_change(Tooltip.Type.NONE, null)

func update_progress():
    if harvestable:
        return
    current_progress += plant_resource.dominant_gene.speed * 25
    set_progress(current_progress)
    if current_progress >= 100:
        set_ready_for_harvest()

func set_progress(value: float):
    progress_bar.value = value

func is_occupied() -> bool:
    return plant_resource != null or trellis

func has_plant() -> bool:
    return plant_resource != null

func setup_plant(plant: Plant):
    plant_resource = plant
    label.text = plant.display_character

func remove_plant():
    plant_resource = null
    label.text = ''
    label.modulate = Color.WHITE
    progress_bar.value = 0
    harvestable = false
    current_progress = 0

func set_ready_for_harvest():
    print('ready!')
    harvestable = true
    label.modulate = Color.LIME_GREEN

func add_trellis():
    $TextureRect.modulate = Color.BROWN
    trellis = true

func remove_trellis():
    $TextureRect.modulate = Color.GRAY
    trellis = false

func clear_spot():
    remove_trellis()
    remove_plant()