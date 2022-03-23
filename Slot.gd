extends Panel

var ItemClass = preload("res://Item.tscn")
var ToolTipClass = preload("res://ToolTip.tscn")
var item = null
var slot_index

func _ready():
	
	pass
	#if randi() % 2 == 0:
		#item = ItemClass.instance()
		#add_child(item)

func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null

func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)

func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)

func _on_Slot1_mouse_entered():
	var toolTipInstance = ToolTipClass.instance()
	toolTipInstance.rect_position = get_global_transform_with_canvas().origin - Vector2(300,0)
	
	add_child(toolTipInstance)
	yield(get_tree().create_timer(0.1), "timeout")
	if has_node("ToolTip") && has_node("Item"):
		var slotToolTip = get_node("ToolTip")
		var itemName = get_node("Item").item_name
		slotToolTip.setItemName(itemName)
		#JsonData.item_data[item_name]["StackSize"]
		slotToolTip.setDescription(JsonData.item_data[itemName]["Description"])
		slotToolTip.show()

func _on_Slot1_mouse_exited():
	get_node("ToolTip").free()

