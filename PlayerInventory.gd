extends Node

const SlotClass = preload("res://Slot.gd")
const ItemClass = preload("res://Item.gd")

const NUM_INVENTORY_SLOTS = 20

# Dictionary to store items
# Format is index: [ITEM_NAME, QUANTITY]
var inventory = {
	0: ["Health_Potion", 2]
	#0: ["Health_Potion", 1]
}

func add_item(item_name, item_quantity):
	#Add item into inventory if it aleady exists
	for item in inventory:
		if inventory[item][0] == item_name:
			# This block of code is for overflow stack sizes, shouldn't matter right now
			"""
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				return
			else:
				inventory[item][1] += able_to_add
				item_quantity = item_quantity - able_to_add 
				"""
			inventory[item][1] += item_quantity
			return
	
	# Add item if it doesn't exist
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			return

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]

func remove_item(slot: SlotClass):
	inventory.erase(slot.slot_index)

func add_item_quantity(slot: SlotClass, quantity_to_add: int):
	inventory[slot.slot_index][1] += quantity_to_add
