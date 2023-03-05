class_name Block
extends Resource

var block_id: StringName
var voxel_id: int
var name: StringName
var color: Color
var geometry_type := VoxelBlockyModel.GEOMETRY_CUBE


func _init(p_block_id) -> void:
	block_id = p_block_id
