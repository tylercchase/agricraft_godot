
class_name PlantGrowthManager
extends Node


@export var plant_grid_container: PlantGridContainer

@export var plant_manager: PlantManager

var timer: Timer

func _ready() -> void:
    timer = Timer.new()
    timer.autostart = false
    add_child(timer)
    timer.start(1)
    timer.timeout.connect(_on_timer_check)


func filter_boxes(box: PlantBox):
    return box.has_plant() # change future to consider more stuff

func filter_trellis(box: PlantBox):
    return box.trellis

func _on_timer_check():
    var plants_with_stuff: Array[PlantBox] = plant_grid_container.boxes.filter(filter_boxes)
    for plant_box in plants_with_stuff:
        plant_box.update_progress()
    var trellises: Array[PlantBox] = plant_grid_container.boxes.filter(filter_trellis)
    for trellis in trellises:
        check_valid_trellis(trellis.id)

func check_valid_trellis(box_id):
    # in the future possible mutations could include multi part plant setups
    # maybe define in resources of Plants

    # for now just go with basic cardinal directions
    var left_plant: PlantBox = plant_grid_container.get_box_offset(box_id, 0, -1)
    var right_plant: PlantBox = plant_grid_container.get_box_offset(box_id, 0, 1)
    var up_plant: PlantBox = plant_grid_container.get_box_offset(box_id, -1, 0)
    var down_plant: PlantBox = plant_grid_container.get_box_offset(box_id, 1, 0)


    if up_plant && up_plant.plant_resource == null && down_plant && down_plant.plant_resource == null:
        if left_plant && left_plant.plant_resource && right_plant && right_plant.plant_resource && left_plant.harvestable && right_plant.harvestable:
            create_child_plant(box_id, [left_plant.plant_resource, right_plant.plant_resource])
    elif left_plant && left_plant.plant_resource == null && right_plant && right_plant.plant_resource == null:
        if up_plant && up_plant.plant_resource && down_plant && down_plant.plant_resource && up_plant.harvestable && down_plant.harvestable:
            create_child_plant(box_id, [up_plant.plant_resource, down_plant.plant_resource])

func create_child_plant(box_id, parents: Array[Plant]):

    # TODO: For now just handle two parents, later possibly more?
    var parent1 = parents[0]
    var parent2 = parents[1]
    if parent1.id != parent2.id: # for now only mutate plants that are the same
        return
    var plant_resource: Plant = parent1.duplicate()
    var genomes = calculate_final_genomes(parent1, parent2)
    plant_resource.dominant_gene = genomes[0]
    plant_resource.recessive_gene = genomes[1]

    print(genomes) # do something here later, probably plant it where it was
    plant_manager.clear_space(box_id)
    plant_manager.plant_crop(plant_resource, box_id)

func calculate_final_genomes(plant1: Plant, plant2: Plant) -> Array[Plant.Genome]:

    #this feels way too cumbersome, there's gotta be a better way
    var speed_values = calc_gene(plant1.dominant_gene.speed, plant2.dominant_gene.speed, plant1.recessive_gene.speed, plant2.recessive_gene.speed)
    var bounty_values = calc_gene(plant1.dominant_gene.bounty, plant2.dominant_gene.bounty, plant1.recessive_gene.bounty, plant2.recessive_gene.bounty)

    var dominant_gene = Plant.Genome.new()
    var recessive_gene = Plant.Genome.new()

    dominant_gene.speed = speed_values[0]
    recessive_gene.speed = speed_values[1]

    dominant_gene.bounty = bounty_values[0]
    recessive_gene.bounty = bounty_values[1]

    return [dominant_gene, recessive_gene]

func mutate(value):
    var chance_to_mutate = 0.5
    if randf() < chance_to_mutate:
        return clamp(value+1,1,10)
    else:
        return value

func calc_gene(d1,d2,r1,r2) -> Array:
    # Punnett Square method inheritance with a decent change of mutating _something_
    # probably not accurate but works for this

    # example square output
    # 7-6 with a 7-6
    # 50% 7-6
    # 25% 7-7
    # 25% 6-6

    # current
    # 7-7
    # 7-6
    # 7-6
    # 6-6
    # not totally accurate but works right now
    var possible_genes = [[d1,d2], [d1,r2], [d2, r1], [r1,r2]] 
    var selected = possible_genes.pick_random()
    var output = selected.map(mutate)

    return output
