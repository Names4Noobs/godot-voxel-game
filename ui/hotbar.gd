#@tool
extends HBoxContainer

var inv_slot = load("res://ui/inventory_slot_display.tscn")
var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")
var icon_size := Vector2(64,64)
var selected_slot: int:
	set(v): 
		await _update_selector(v)
		selected_slot = v


func _ready() -> void:
	for i in voxel_library.voxel_count - 1:
		var slot = inv_slot.instantiate()
		slot.get_node("ColorRect").color = voxel_library.get_voxel(i+1).color
		add_child(slot)


func _make_color_slots() -> void:
	custom_minimum_size = icon_size
	for i in voxel_library.voxel_count - 1:
		var slot := ColorRect.new()
		slot.name = str(i)
		slot.custom_minimum_size = icon_size
		slot.color = voxel_library.get_voxel(i+1).color
		add_child(slot)


func _update_selector(new_id: int) -> void:
	get_child(selected_slot-1).get_node("ColorRect").hide()
	get_child(new_id-1).get_node("ColorRect").show()

