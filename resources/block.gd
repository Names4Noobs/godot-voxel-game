class_name Block
extends Resource

var block_id: StringName
var voxel_id: int
var name: StringName
var color: Color
var geometry_type := VoxelBlockyModel.GEOMETRY_CUBE
# NOTE: This should be replaced with a top, bottom, front, etc 
# position into the block texture atlas
var top_bottom_texture: Texture2D
var side_texture: Texture2D


func _init(p_block_id) -> void:
	block_id = p_block_id
