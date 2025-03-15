
class_name Plant
extends Resource

@export var name: String
@export var id: String

@export var display_character: String
## How many ticks a mid tier (speed 5) seed should need to grow 
## (i.e. a tier 10 seed would grow in half this speed, and a tier one at twice the time )
@export var grow_ticks: int = 10
@export var sell_price: int = 1

var genetics: Genome = Genome.new() # default to base 1



class Genome:
    var mutation: int = 1
    var bounty: int = 1
    var speed: int = 1