extends Node2D

var item_name
var item_quantity

func _ready():
	pass
	###At the start, fill up your inventory with random items (FOR TESTING PUPOSES)
	#var rand_val = randi() % 2
	#if rand_val == 0:
		#item_name = "Health_Potion"
	#else:
		#item_name = "Speed_Potion"
	
	# Load the textures for the items inside the inventory, including the stack size
	#$TextureRect.texture = load("res://item_icons/" + item_name + ".png")
	#var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	#item_quantity = randi() % stack_size + 1
	#if stack_size == 1 || item_quantity == 1:
		#$Label.visible = false
	#else:
		#$Label.text = String(item_quantity)

# Function to add a certain amount of an item to the inventory
func add_item_quantity(amount):
	item_quantity += amount
	$Label.text = String(item_quantity)

# Function to remove a certain amount of an item to the inventory
func decrease_item_quantity(amount):
	item_quantity -= amount
	$Label.text = String(item_quantity)

# Function to set an item and amount inside the inventory
func set_item(NAME, QUANTITY):
	item_name = NAME
	item_quantity = QUANTITY
	$TextureRect.texture = load("res://item_icons/" + item_name + ".png")
	
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	if stack_size == 1 || item_quantity == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = String(item_quantity)
