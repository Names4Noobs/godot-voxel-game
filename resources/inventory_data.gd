extends Resource
class_name Inventory


@export var num_slots := 35
@export var selected_slot := 0:
	set(v):
		selected_slot = wrapi(v, 0, 9)
		Signals.emit_signal("changed_selected_slot", get_selected_slot(), selected_slot)
@export var slots: Array[Resource]


func _init() -> void:
	Signals.connect("inventory_swap_slots", _swap_slots)
	Signals.connect("add_item_to_inventory", add_item_to_stack)
	for i in num_slots+1:
		var slot = InventorySlot.new(i)
		slots.append(slot)

	# Right now this has to be manually done due to resource exporting
	# not working correctly
	slots[0] = InventorySlot.new(3, Util.diamond_shovel_item)
	slots[1] = InventorySlot.new(1, Util.beef_item)
#	slots[0] = InventorySlot.new(0, Util.diamond_sword_item)
#	slots[1] = InventorySlot.new(1, Util.diamond_pickaxe_item)
#	slots[2] = InventorySlot.new(2, Util.diamond_axe_item)

#	slots[4] = InventorySlot.new(4, Util.diamond_hoe_item)

#	slots[6] = InventorySlot.new(6, Util.bow_item)
#	slots[9] = InventorySlot.new(9, Util.crafting_table_item)
#	slots[10] = InventorySlot.new(10, Util.furnace_item)
#	slots[11] = InventorySlot.new(11, Util.tnt_item)
#	slots[12] = InventorySlot.new(12, Util.water_item)
	selected_slot = 0
	Signals.emit_signal("inventory_changed", slots)


func _swap_slots(to: int, from: int) -> void:
	var temp = slots[to]
	slots[from].id = slots[to].id
	slots[to] = slots[from]
	slots[from] = temp
	Signals.emit_signal("inventory_changed", slots)


func get_selected_slot() -> Resource:
	return slots[selected_slot]


# TODO: Instead of passing all of the item data pass in the item id
func add_item_to_stack(item_data: Resource, amount: int) -> void:
	for i in slots:
		if i.has_item(item_data):
			i.quantity += amount
			Signals.emit_signal("inventory_changed", slots)
			return
	add_item_to_empty_slot(item_data, amount)


func add_item_to_empty_slot(item_data: Resource, amount: int) -> void:
	for i in slots:
		if i.is_empty:
			i.is_empty = false
			i.item = item_data
			i.quantity = amount
			Signals.emit_signal("inventory_slot_changed", i)
			return


func drop_stack() -> void:
	drop_item(get_selected_slot().quantity)


func drop_item(amount: int) -> void:
	var slot = get_selected_slot()
	if !slot.is_empty: 
		Signals.emit_signal("drop_item", get_selected_slot().item, Vector3.ZERO, amount, false)
		remove_selected_item(amount)


func remove_selected_item(amount: int) -> void:
	var slot = get_selected_slot()
	if slot != null and !slot.is_empty:
		slot.quantity -= amount
		Signals.emit_signal("inventory_slot_changed", slots[selected_slot])


func is_selected_slot_empty() -> bool:
	if slots[selected_slot].is_empty:
		return true
	else:
		return false
