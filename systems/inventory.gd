extends Node


# The count starts at 0
const MAX_SLOTS = 8

@onready var item = $Item

var slots: Array
var selected_slot = 0:
	get: return selected_slot
	set(v):
		selected_slot = wrapi(v, -1, MAX_SLOTS+1)
		_swap_data()
		Signals.emit_signal("changed_selected_slot", selected_slot)


func _ready() -> void:
	Signals.connect("inventory_swap_slots", Callable(self, "_swap_slots"))
	for i in MAX_SLOTS+1:
		var slot = InventorySlot.new(preload("res://data/blocks/dirt_item.tres"), 16)
		slots.append(slot) 
	# NOTE: Manually setting the item data is temporary!
	slots[0].item = preload("res://data/blocks/dirt_item.tres")
	slots[1].item = preload("res://data/blocks/grass_item.tres")
	slots[2].item = preload("res://data/blocks/water_item.tres")
	slots[3].item = preload("res://data/blocks/sand_item.tres")
	slots[4].item = preload("res://data/blocks/log_item.tres")
	slots[5].item = preload("res://data/blocks/leaf_item.tres")
	Signals.emit_signal("inventory_changed", slots)


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released("scroll_up"):
		selected_slot += 1
	elif Input.is_action_just_released("scroll_down"):
		selected_slot -= 1
	elif Input.is_action_just_pressed("select_slot1"):
		selected_slot = 0
	elif Input.is_action_just_pressed("select_slot2"):
		selected_slot = 1
	elif Input.is_action_just_pressed("select_slot3"):
		selected_slot = 2
	elif Input.is_action_just_pressed("select_slot4"):
		selected_slot = 3
	elif Input.is_action_just_pressed("select_slot5"):
		selected_slot = 4
	elif Input.is_action_just_pressed("select_slot6"):
		selected_slot = 5
	elif Input.is_action_just_pressed("select_slot7"):
		selected_slot = 6
	elif Input.is_action_just_pressed("select_slot8"):
		selected_slot = 7
	elif Input.is_action_just_pressed("select_slot9"):
		selected_slot = 8
	elif Input.is_action_just_pressed("drop_stack"):
		if slots[selected_slot] != null:
			if !slots[selected_slot].is_empty():
				slots[selected_slot].quantity = 0
				Signals.emit_signal("drop_item", preload("res://data/blocks/sand_item.tres"))
				Signals.emit_signal("item_amount_changed")
	elif Input.is_action_just_pressed("drop_item"):
		if slots[selected_slot] != null:
			if !slots[selected_slot].is_empty():
				slots[selected_slot].quantity -= 1
				Signals.emit_signal("drop_item", preload("res://data/blocks/dirt_item.tres"))
				Signals.emit_signal("item_amount_changed")


func _swap_data() -> void:
	if item != null:
		item.data = slots[selected_slot].item


func _swap_slots(slot1: int, slot2: int) -> void:
	var temp = slots[slot1]
	slots[slot1] = slots[slot2]
	slots[slot2] = temp
	Signals.emit_signal("inventory_changed", slots)


# Removes amount from current slot
func remove_amount(amount: int) -> void:
	if slots[selected_slot] != null:
		slots[selected_slot].quantity -= amount
		if slots[selected_slot].quantity <= 0:
			slots[selected_slot] = null


func get_selected_item() -> Node:
	return item
