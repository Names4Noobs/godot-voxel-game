class_name Inventory
extends Node

signal selected_slot_changed

const NUMBER_OF_SLOTS := 36
var slots: Array[ItemStack]
var selected_slot := 0:
	set(v):
		selected_slot = wrapi(v, 0, 8)
		emit_signal("selected_slot_changed")


func _ready() -> void:
	Game.player_inventory = self
	_generate_slots()
	slots[0].item = Game.items["grass_block"]
	slots[0].amount = 64


func _input(event: InputEvent) -> void:
	if event.is_action_released("scroll_up"):
		selected_slot += 1
	elif event.is_action_released("scroll_down"):
		selected_slot -= 1


func add_item_stack(stack: ItemStack) -> void:
	for slot in slots:
		if slot.item == stack.item:
			slot.amount += stack.amount
			return
	for slot in slots:
		if slot.is_empty():
			slot.item = stack.item
			slot.amount = stack.amount


func get_selected_slot() -> ItemStack:
	return slots[selected_slot]


func _generate_slots() -> void:
	for i in range(NUMBER_OF_SLOTS):
		slots.append(ItemStack.new())
