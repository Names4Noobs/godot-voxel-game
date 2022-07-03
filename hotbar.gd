@tool
extends HBoxContainer

var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")



func _ready() -> void:
	for i in voxel_library.voxel_count - 1:
		var slot = TextureRect.new()
		slot.texture = load("res://icon.png")
		slot.modulate = voxel_library.get_voxel(i+1).color
		add_child(slot)

