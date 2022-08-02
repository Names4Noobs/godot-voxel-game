extends Resource
class_name Inventory


@export var num_slots := 35
@export var selected_slot := 0:
	set(v):
		selected_slot = wrapi(v, 0, 9)
		Signals.emit_signal("changed_selected_slot", get_selected_slot(), selected_slot)
@export var slots: Array[Resource]


func _init() -> void:
	Signals.connect("inventory_swap_slots", Callable(self, "_swap_slots"))
	for i in num_slots+1:
		var slot = InventorySlot.new(i)
		slots.append(slot)

	# Right now this has to be manually done due to resource exporting
	# not working correctly
	slots[0] = InventorySlot.new(0, Util.diamond_sword_item, 1)
	slots[1] = InventorySlot.new(1, Util.diamond_pickaxe_item, 1)
	slots[2] = InventorySlot.new(2, Util.diamond_axe_item, 1)
	slots[3] = InventorySlot.new(3, Util.diamond_shovel_item, 1)
	slots[4] = InventorySlot.new(4, Util.diamond_hoe_item, 1)
	slots[5] = InventorySlot.new(5, Util.beef_item, 64)
	slots[6] = InventorySlot.new(6, Util.bow_item, 1)
	slots[9] = InventorySlot.new(9, Util.crafting_table_item, 64)
	slots[10] = InventorySlot.new(10, Util.furnace_item, 64)
	slots[11] = InventorySlot.new(11, Util.tnt_item, 64)
	slots[12] = InventorySlot.new(12, Util.water_item, 64)
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
