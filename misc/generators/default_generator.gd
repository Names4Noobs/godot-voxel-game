class_name DefaultGenerator
extends VoxelGeneratorScript

const CHANNEL := VoxelBuffer.CHANNEL_TYPE

var _heightmap_noise := ZN_FastNoiseLite.new()
var _heightmap_min = -5
var _heightmap_max = 5

func _init() -> void:
	pass


func _get_used_channels_mask() -> int:
	return 1 << CHANNEL


func _generate_block(out_buffer: VoxelBuffer, origin_in_voxels: Vector3i, _lod: int) -> void:
	# NOTE: I probably don't need to check the size because it shouldn't be changing
	# but why not.....
	var chunk_size := out_buffer.get_size().x
	var chunk_pos := Vector3i(
	origin_in_voxels.x/chunk_size,
	origin_in_voxels.y/chunk_size,
	origin_in_voxels.z/chunk_size)
	
	
	if origin_in_voxels.y > _heightmap_max:
		out_buffer.fill(0, CHANNEL)
	elif origin_in_voxels.y < _heightmap_min:
		out_buffer.fill(2, CHANNEL)
	else:
		for z in chunk_size:
			for x in chunk_size:
				var height = _heightmap_noise.get_noise_2d(x+origin_in_voxels.x, z+origin_in_voxels.z) * 5
				var relative_height = height + 5
				for y in chunk_size:
					out_buffer.set_voxel(2, x, relative_height, z, CHANNEL)
				
			
			
#if relative_height > chunk_size:
#					out_buffer.fill_area(1, Vector3i(x, 0, z), Vector3(x+1, chunk_size, z+1), CHANNEL)
#				elif relative_height > 0:
#					out_buffer.fill_area(1, Vector3i(x, 0, z), Vector3(x+1, relative_height, z+1), CHANNEL)
#					if height >= 0:
