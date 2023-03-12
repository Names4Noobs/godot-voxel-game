extends Node3D

const DefaultTexture := preload("res://assets/icon.svg")

enum BlockFace {EAST, WEST, UP, DOWN, SOUTH, NORTH}

var east_material
var west_material
var north_material
var south_material
var up_material

@onready var block_model: MeshInstance3D = $default_block/Node2/cube

func _ready() -> void:
	block_model.set_surface_override_material(BlockFace.EAST, _create_block_material())
	block_model.set_surface_override_material(BlockFace.WEST, _create_block_material())
	block_model.set_surface_override_material(BlockFace.NORTH, _create_block_material())
	block_model.set_surface_override_material(BlockFace.SOUTH, _create_block_material())
	block_model.set_surface_override_material(BlockFace.UP, _create_block_material())
	block_model.set_surface_override_material(BlockFace.DOWN, _create_block_material())


func delete() -> void:
	block_model.set_surface_override_material(BlockFace.EAST, null)
	block_model.set_surface_override_material(BlockFace.WEST, null)
	block_model.set_surface_override_material(BlockFace.NORTH, null)
	block_model.set_surface_override_material(BlockFace.SOUTH, null)
	block_model.set_surface_override_material(BlockFace.UP, null)
	block_model.set_surface_override_material(BlockFace.DOWN, null)


func set_block_textures(block_data: Block) -> void:
	_set_texture_if_not_null(BlockFace.EAST, block_data.east_texture)
	_set_texture_if_not_null(BlockFace.WEST, block_data.west_texture)
	_set_texture_if_not_null(BlockFace.NORTH, block_data.north_texture)
	_set_texture_if_not_null(BlockFace.SOUTH, block_data.south_texture)
	_set_texture_if_not_null(BlockFace.UP, block_data.up_texture)
	_set_texture_if_not_null(BlockFace.DOWN, block_data.down_texture)


func _set_texture_if_not_null(face: int, texture: Texture2D) -> void:
	var material := block_model.get_surface_override_material(face)
	if texture != null:
		material.albedo_texture = texture
	else:
		material.albedo_texture = DefaultTexture

func _create_block_material() -> StandardMaterial3D:
	var new_material := StandardMaterial3D.new()
	new_material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
	new_material.albedo_texture = DefaultTexture
	return new_material
