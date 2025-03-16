
class_name Plant
extends Resource

@export var name: String
@export var id: String

@export var display_character: String
## How many ticks a mid tier (speed 5) seed should need to grow 
## (i.e. a tier 10 seed would grow in half this speed, and a tier one at twice the time )
@export var grow_ticks: int = 10
@export var sell_price: int = 1

@export var output = "Wheat" # probably make something here that fits better
# make a resource here, would work a lot better

var dominant_gene: Genome = Genome.new()
var recessive_gene: Genome = Genome.new()


class Genome:
    # var mutation: int = 1
    var bounty: int = 1
    var speed: int = 1

    func _to_string() -> String:
        return "%d-%d" % [bounty, speed]