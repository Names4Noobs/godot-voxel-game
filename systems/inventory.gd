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

# NOTE: These variables are temporary
var _dirt_item := preload("res://data/blocks/dirt_item.tres")
var _grass_item := preload("res://data/blocks/grass_item.tres")
var _water_item := preload("res://data/blocks/water_item.tres")
var _sand_item := preload("res://data/blocks/sand_item.tres")
var _log_item := preload("res://data/blocks/log_item.tres")
var _leaf_item := preload("res://data/blocks/leaf_item.tres")
var _beef_item := preload("res://data/blocks/beef_item.tres")
var _crafting_table_item := preload("res://data/blocks/crafting_table_item.tres")
var _furnace_item := preload("res://data/blocks/furnace_item.tres")


func _ready() -> void:
	Signals.connect("inventory_swap_slots", Callable(self, "_swap_slots"))
	for i in MAX_SLOTS+1:
		var slot = InventorySlot.new(_dirt_item, 16)
		slots.append(slot) 
	# NOTE: Manually setting the item data is temporary!
	slots[0].item = _dirt_item
	slots[1].item = _grass_item
	slots[2].item = _water_item
	slots[3].item = _sand_item
	slots[4].item = _log_item
	slots[5].item = _leaf_item
	slots[6].item = _beef_item
	slots[7].item = _crafting_table_item
	slots[8].item = _furnace_item
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
			slots[selected_slot].quantity = 0
			if !slots[selected_slot].is_empty():
				Signals.emit_signal("drop_item", slots[selected_slot].item)
				Signals.emit_signal("item_amount_changed")
	elif Input.is_action_just_pressed("drop_item"):
		if slots[selected_slot] != null:
			slots[selected_slot].quantity -= 1
			if !slots[selected_slot].is_empty():
				Signals.emit_signal("drop_item", slots[selected_slot].item, false)
				Signals.emit_signal("item_amount_changed")


func _swap_data() -> void:
	if item != null:
		item.data = slots[selected_slot].item


func _swap_slots(slot1: int, slot2: int) -> void:
	var temp = slots[slot1]
	slots[slot1] = slots[slot2]
	slots[slot2] = temp
	Signals.emit_signal("inventory_changed", slots)


# NOTE: Temporary
func remove_amount(amount: int) -> void:
	if slots[selected_slot] != null:
		slots[selected_slot].quantity -= amount
		Signals.emit_signal("item_amount_changed")
