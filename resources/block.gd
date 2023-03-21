class_name Block
extends Resource

enum ToolCategory {AXE, SHOVEL, PICKAXE, HOE, SWORD}

var block_id: StringName
var voxel_id: int
var name: StringName
var color := Color.WHITE
var geometry_type := VoxelBlockyModel.GEOMETRY_CUBE
var random_tickable := false
var tool_category: int
var can_break := true

# NOTE: This should be replaced with a top, bottom, front, etc 
# position into the block texture atlas
var up_texture: Texture2D
var down_texture: Texture2D
var east_texture: Texture2D
var west_texture: Texture2D
var north_texture: Texture2D
var south_texture: Texture2D

func _init(p_block_id) -> void:
	block_id = p_block_id


func set_single_texture(texture: Texture2D) -> void:
	up_texture = texture
	down_texture = texture
	east_texture = texture
	west_texture = texture
	north_texture = texture
	south_texture = texture


func set_two_textures(top_texture: Texture2D, side_texture: Texture2D) -> void:
	up_texture = top_texture
	down_texture = top_texture
	east_texture = side_texture
	west_texture = side_texture
	north_texture = side_texture
	south_texture = side_texture
