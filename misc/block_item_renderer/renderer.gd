extends Node3D

@onready var viewport := $SubViewport
@onready var block_model := $SubViewport/RenderScene/log/Node2/cube

func _ready() -> void:
	_render_blocks()


func _render_blocks() -> void:
	for block in Game.blocks:
		var block_data := Game.get_block(block)
		if block_data.geometry_type == VoxelBlockyModel.GEOMETRY_NONE:
			continue
		if block_data.top_bottom_texture != null:
			block_model.set_surface_override_material(1, create_block_material(block_data.top_bottom_texture))
		if block_data.side_texture != null:
			var side_mat := create_block_material(block_data.side_texture)
			block_model.set_surface_override_material(0, side_mat)
			block_model.set_surface_override_material(2, side_mat)
		await RenderingServer.frame_post_draw
		viewport.get_texture().get_image().save_png("res://assets/textures/item/%s.png" % block_data.block_id)
		block_model.set_surface_override_material(0, null)
		block_model.set_surface_override_material(1, null)
		block_model.set_surface_override_material(2, null)
	get_tree().quit()


func create_block_material(texture: Texture2D) -> StandardMaterial3D:
	var new_material := StandardMaterial3D.new()
	new_material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
	new_material.albedo_texture = texture
	return new_material
