# TODO: Name this hotbar
class_name Hotbar
extends Node

signal selected_slot_changed(new_slot: int)

const NUMBER_OF_SLOTS := 36

@export var player: Player

var selected_slot := 0:
	set(v):
		selected_slot = wrapi(v, 0, 9)
		emit_signal("selected_slot_changed", selected_slot)


func _ready() -> void:
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
	for slot in player.get_inventory().slots:
		if slot.item == stack.item:
			slot.amount += stack.amount
			return
	for slot in player.get_inventory().slots:
		if slot.is_empty():
			slot.item = stack.item
			slot.amount = stack.amount
			return


func get_selected_slot() -> ItemStack:
	return player.get_inventory().slots[selected_slot]


func _generate_slots() -> void:
	for i in range(NUMBER_OF_SLOTS):
		player.get_inventory().slots.append(ItemStack.new())
