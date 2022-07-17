extends Resource
class_name Inventory


@export var num_slots := 8
@export var selected_slot := 0:
	set(v):
		selected_slot = wrapi(v, 0, num_slots+1)
		Signals.emit_signal("changed_selected_slot", get_selected_slot(), selected_slot)
@export var slots: Array[Resource]


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


func _init() -> void:
	Signals.connect("inventory_swap_slots", Callable(self, "_swap_slots"))
	for i in num_slots+1:
			var slot = InventorySlot.new(_dirt_item, 16)
			slots.append(slot)
	# Right now this has to be manually done due to resource exporting
	# not working correctly
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



func _swap_slots(slot1: int, slot2: int) -> void:
	var temp = slots[slot1]
	slots[slot1] = slots[slot2]
	slots[slot2] = temp
	Signals.emit_signal("inventory_changed", slots)


func get_selected_slot() -> Resource:
	return slots[selected_slot]
