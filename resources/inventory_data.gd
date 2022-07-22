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
		if i >= 9:
			break
		var slot = InventorySlot.new(Util._dirt_item, 16)
		slots.append(slot)
	for i in num_slots-8:
		var slot = InventorySlot.new()
		slots.append(slot)
	# Right now this has to be manually done due to resource exporting
	# not working correctly
	slots[0].item = Util._diamond_sword_item
	slots[1].item = Util._tnt_item
	slots[2].item = Util._water_item
	slots[3].item = Util._sand_item
	slots[4].item = Util._dirt_item
	slots[5].item = Util._leaf_item
	slots[6].item = Util._beef_item
	slots[7].item = Util._crafting_table_item
	slots[8].item = Util._furnace_item
	Signals.emit_signal("inventory_changed", slots)



func _swap_slots(slot1: int, slot2: int) -> void:
	var temp = slots[slot1]
	slots[slot1] = slots[slot2]
	slots[slot2] = temp
	Signals.emit_signal("inventory_changed", slots)


func get_selected_slot() -> Resource:
	return slots[selected_slot]


# TODO: Instead of passing all of the item data pass in the item id
func add_item_to_stack(item_data: Resource, amount: int) -> void:
	for i in slots:
		if i.has_item(item_data):
			i.quantity += amount
	Signals.emit_signal("inventory_changed", slots)
