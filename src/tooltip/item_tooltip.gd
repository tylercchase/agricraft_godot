extends PanelContainer


func setup(data: InventoryItem):
    print(data)
    %NameLabel.text = data.name
    %DescriptionLabel.text = data.description
