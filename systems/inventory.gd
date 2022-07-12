extends Node

var slots: Array
var selected_slot = 1:
	get: return selected_slot
	set(v):
		selected_slot = clamp(v, 1, MAX_SLOTS)
		_swap_data()
		Signals.emit_signal("changed_selected_slot", selected_slot)
@onready var block_item = $BlockItem

const InventorySlot = preload("res://systems/inventory/slot.gd")
const MAX_SLOTS = 9

func _ready() -> void:
	for i in MAX_SLOTS:
		var slot = InventorySlot.new(preload("res://data/blocks/dirt_block.tres"), 64)
		slots.append(slot) 
	# NOTE: Manually setting the item data is temporary!
	slots[0].item = preload("res://data/blocks/dirt_block.tres")
	slots[1].item = preload("res://data/blocks/grass_block.tres")
	slots[2].item = preload("res://data/blocks/water_block.tres")
	slots[5].item = preload("res://data/blocks/leaf_block.tres")

	Signals.emit_signal("inventory_loaded", slots)


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released("scroll_up"):
		selected_slot += 1
	elif Input.is_action_just_released("scroll_down"):
		selected_slot -= 1
	elif Input.is_action_just_pressed("select_slot1"):
		selected_slot = 1
		
	elif Input.is_action_just_pressed("select_slot2"):
		selected_slot = 2
	elif Input.is_action_just_pressed("select_slot3"):
		selected_slot = 3
	elif Input.is_action_just_pressed("select_slot4"):
		selected_slot = 4
	elif Input.is_action_just_pressed("select_slot5"):
		selected_slot = 5
	elif Input.is_action_just_pressed("select_slot6"):
		selected_slot = 6
	elif Input.is_action_just_pressed("select_slot7"):
		selected_slot = 7
	elif Input.is_action_just_pressed("select_slot8"):
		selected_slot = 8
	elif Input.is_action_just_pressed("select_slot9"):
		selected_slot = 9

func _swap_data() -> void:
	if block_item != null:
		block_item.data = slots[selected_slot-1].item


func get_selected_item() -> Node:
	return $BlockItem
