class_name FlatlandGenerator
extends VoxelGeneratorScript

const CHANNEL := VoxelBuffer.CHANNEL_TYPE

func _init() -> void:
	pass


func _get_used_channels_mask() -> int:
	return 1 << CHANNEL

func _generate_block(out_buffer: VoxelBuffer, origin_in_voxels: Vector3i, _lod: int) -> void:
	var chunk_size := out_buffer.get_size().x
	@warning_ignore("integer_division")
	var chunk_pos := Vector3i(
	origin_in_voxels.x/chunk_size,
	origin_in_voxels.y/chunk_size,
	origin_in_voxels.z/chunk_size)
	if chunk_pos.y == -1:
		out_buffer.fill(Game.VoxelId.GRASS)
		out_buffer.fill_area(Game.VoxelId.DIRT, Vector3i.ZERO, Vector3i(chunk_size, chunk_size-1, chunk_size))
	elif chunk_pos.y < -1 and chunk_pos.y > -3:
		out_buffer.fill(Game.VoxelId.STONE)
	elif chunk_pos.y == -3:
		out_buffer.fill_area(6, Vector3i(0, chunk_size-1, 0), Vector3i(chunk_size, chunk_size, chunk_size))
