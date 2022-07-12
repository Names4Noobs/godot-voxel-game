extends Node

var slots: Array
var selected_slot = 0:
	get: return selected_slot
	set(v):
		selected_slot = wrapi(v, -1, MAX_SLOTS+1)
		_swap_data()
		Signals.emit_signal("changed_selected_slot", selected_slot)
@onready var block_item = $BlockItem

const InventorySlot = preload("res://systems/inventory/slot.gd")
# The count starts at 0
const MAX_SLOTS = 8

func _ready() -> void:
	Signals.connect("inventory_swap_slots", Callable(self, "_swap_slots"))
	for i in MAX_SLOTS+1:
		var slot = InventorySlot.new(preload("res://data/blocks/dirt_block.tres"), 64)
		slots.append(slot) 
	# NOTE: Manually setting the item data is temporary!
	slots[0].item = preload("res://data/blocks/dirt_block.tres")
	slots[1].item = preload("res://data/blocks/grass_block.tres")
	slots[2].item = preload("res://data/blocks/water_block.tres")
	slots[5].item = preload("res://data/blocks/leaf_block.tres")

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

func _swap_data() -> void:
	if block_item != null:
		block_item.data = slots[selected_slot].item

func _swap_slots(slot1: int, slot2: int) -> void:
	var temp = slots[slot1]
	slots[slot1] = slots[slot2]
	slots[slot2] = temp
	Signals.emit_signal("inventory_changed", slots)

func get_selected_item() -> Node:
	return $BlockItem
