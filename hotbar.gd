@tool
extends HBoxContainer

var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")
var icon_size := Vector2(64,64)
var selected_slot: int:
	set(v): 
		_update_selector(v)  
		selected_slot = v

func _ready() -> void:
	custom_minimum_size = icon_size
	for i in voxel_library.voxel_count - 1:
		var slot := ColorRect.new()
		slot.custom_minimum_size = icon_size
		slot.color = voxel_library.get_voxel(i+1).color
		add_child(slot)

func _update_selector(new_id: int) -> void:
	pass
