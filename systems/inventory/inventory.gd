# TODO: Name this player inventory b/c a inventory resource needs to be created
class_name Inventory
extends Node

signal selected_slot_changed(new_slot: int)

const NUMBER_OF_SLOTS := 36
var slots: Array[ItemStack]
var selected_slot := 0:
	set(v):
		selected_slot = wrapi(v, 0, 9)
		emit_signal("selected_slot_changed", selected_slot)


func _ready() -> void:
	Game.player_inventory = self
	_generate_slots()
	add_item_stack(ItemStack.create_full_stack("wooden_sword"))
	add_item_stack(ItemStack.create_full_stack("wooden_pickaxe"))
	add_item_stack(ItemStack.create_full_stack("wooden_axe"))
	add_item_stack(ItemStack.create_full_stack("wooden_shovel"))
	add_item_stack(ItemStack.create_full_stack("wooden_hoe"))
	add_item_stack(ItemStack.create_full_stack("leaf_block"))
	add_item_stack(ItemStack.create_full_stack("chest"))
	Game.register_inventory(0, slots)
	selected_slot = 0


func _input(event: InputEvent) -> void:
	if event.is_action_released("scroll_up"):
		selected_slot += 1
	elif event.is_action_released("scroll_down"):
		selected_slot -= 1
	elif event.is_action_released("select_slot_1"):
		selected_slot = 0
	elif event.is_action_released("select_slot_2"):
		selected_slot = 1
	elif event.is_action_released("select_slot_3"):
		selected_slot = 2
	elif event.is_action_released("select_slot_4"):
		selected_slot = 3
	elif event.is_action_released("select_slot_5"):
		selected_slot = 4
	elif event.is_action_released("select_slot_6"):
		selected_slot = 5
	elif event.is_action_released("select_slot_7"):
		selected_slot = 6
	elif event.is_action_released("select_slot_8"):
		selected_slot = 7
	elif event.is_action_released("select_slot_9"):
		selected_slot = 8


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


func get_selected_slot() -> ItemStack:
	return slots[selected_slot]


func _generate_slots() -> void:
	for i in range(NUMBER_OF_SLOTS):
		slots.append(ItemStack.new())
