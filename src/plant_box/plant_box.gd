
class_name PlantBox
extends Button

var place_index: int

func _ready():
    pass

func set_progress(value: float):
    $ProgressBar.value = value