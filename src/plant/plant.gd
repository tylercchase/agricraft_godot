
class_name Plant
extends Resource

@export var name: String
@export var id: String

@export_file("*.svg") var product_image: String
@export_file("*.svg") var crop_image: String

@export var grow_ticks: int = 10
@export var sell_price: int = 1

var genetics: Genome



class Genome:
    var mutation: int = 1
    var bounty: int = 1
    var speed: int = 1