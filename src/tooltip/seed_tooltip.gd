extends Control


func setup(data: Plant):
    %NameLabel.text = data.name
    %DSpeedLabel.text = str(data.dominant_gene.speed)
    %RSpeedLabel.text = str(data.recessive_gene.speed)

    %DBountyLabel.text = str(data.dominant_gene.bounty)
    %RBountyLabel.text = str(data.recessive_gene.bounty)

    # %DMutabilityLabel.text = str(data.dominant_gene.mutation)
    # %RMutabilityLabel.text = str(data.recessive_gene.mutation)