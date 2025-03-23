extends Button


func setup(data: InventoryManager.ItemSlot, selected=false):
    if data.item is Plant:
        var plant = data.item as Plant
        %D1.text = str(plant.dominant_gene.bounty)
        %D2.text = str(plant.dominant_gene.speed)
        %R1.text = str(plant.recessive_gene.bounty)
        %R2.text = str(plant.recessive_gene.speed)
    %CountLabel.text = str(data.amount) + 'x'
    text = data.item.display_character
    if selected:
        modulate = Color('b09597')
