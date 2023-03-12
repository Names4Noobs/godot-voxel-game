extends Node3D

@onready var viewport := $SubViewport
@onready var block_renderer := $SubViewport/RenderScene/BlockRenderer


func _ready() -> void:
	_render_blocks()


func _render_blocks() -> void:
	for block in Game.blocks:
		var block_data: Block = Game.get_block(block)
		if block_data.geometry_type == VoxelBlockyModel.GEOMETRY_NONE:
			continue
		block_renderer.set_block_textures(block_data)
		
		await RenderingServer.frame_post_draw
		viewport.get_texture().get_image().save_png("res://assets/textures/item/%s.png" % block_data.block_id)
	get_tree().quit()
