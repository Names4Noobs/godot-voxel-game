class_name Inventory
extends Node

const NUMBER_OF_SLOTS := 36


var number_of_slots: int
var slots: Array[ItemStack]


func _init(p_number_of_slots: int = NUMBER_OF_SLOTS) -> void:
	number_of_slots = p_number_of_slots
	_generate_slots()


func add_item_stack(stack: ItemStack) -> void:
	for slot in slots:
		if slot.item == stack.item:
			slot.amount += stack.amount
			return
	for slot in slots:
		if slot.is_empty():
			slot.item = stack.item
			slot.amount = stack.amount
			return


func _generate_slots() -> void:
	var slots_needed := number_of_slots - len(slots)
	for i in range(slots_needed):
		slots.append(ItemStack.new())
