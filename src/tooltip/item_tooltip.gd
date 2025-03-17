extends PanelContainer


func setup(data: InventoryItem):
    %NameLabel.text = data.name
    %DescriptionLabel.text = data.description
