extends Popup

onready var ItemName = $N/M/V/ItemName
onready var Description = $N/M/V/Description

func _ready():
	pass

func setItemName(itemname):
	ItemName.text = itemname

func setDescription(description):
	Description.text = description
