extends VoxelGeneratorScript


enum Biome {PLAINS, DESERT}

const channel: int = VoxelBuffer.CHANNEL_TYPE
const DEFAULT_WORLD_SEED = 123456

var world_seed: int
var _biome_noise := FastNoiseLite.new()


func _init(p_world_seed=DEFAULT_WORLD_SEED) -> void:
	world_seed = p_world_seed
	_biome_noise.seed = world_seed
	_biome_noise.frequency = 0.001
	_biome_noise.fractal_octaves = 4


func _get_used_channels_mask() -> int:
	return 1 << channel


func _generate_block(out_buffer: VoxelBuffer, origin_in_voxels: Vector3i, lod: int) -> void:
	if lod != 0:
		return
	var rng = RandomNumberGenerator.new()
	rng.seed = world_seed
	rng.randomize()
	var _block_size := int(out_buffer.get_size().x)
#	var _chunk_position := Vector3i(origin_in_voxels.x >> 4, origin_in_voxels.y >> 4, origin_in_voxels.z >> 4)
	
	var gz = origin_in_voxels.z
	var gx: int
	if origin_in_voxels.y < 1 and origin_in_voxels.y > -16:
		for z in _block_size:
			gx = origin_in_voxels.x
			for x in _block_size:
				if _get_chunk_biome(gz, gx) == Biome.PLAINS:
					out_buffer.set_voxel(2, x, 0, z, channel)
				else:
					out_buffer.set_voxel(3, x, 0, z, channel)
					gx += 1
			gz += 1

	else:
		_generate_plains(out_buffer, origin_in_voxels)



func _get_chunk_biome(x: int, z: int) -> int:
	var result = 0.5 + 0.5 * _biome_noise.get_noise_2d(x, z)
	if result < 0.5:
		return Biome.PLAINS
	else:
		return Biome.DESERT


func _generate_plains(buffer: VoxelBuffer, origin: Vector3i) -> void:
	const chunk_depth = 16
	var rng = RandomNumberGenerator.new()
	rng.seed = world_seed
	rng.randomize()

	if origin.y < 0 and origin.y > -17:
		# Fill grass block for top layer
		buffer.fill_area(Util.Block.GRASS, Vector3i(0,15,0), Vector3i(16,16,16))
		buffer.fill_area(Util.Block.DIRT, Vector3i(0,10,0), Vector3i(16,15,16))
		buffer.fill_area(Util.Block.STONE, Vector3i.ZERO, Vector3i(16,10,16))

	elif origin.y < -16 and origin.y > -33:
		buffer.fill(Util.Block.COAL_ORE, channel)
	elif origin.y < -32 and origin.y > -49:
		buffer.fill(Util.Block.IRON_ORE, channel)
	elif origin.y < -48 and origin.y > -65:
		buffer.fill(Util.Block.GOLD_ORE, channel)
	elif origin.y < -64 and origin.y > -81:
		buffer.fill(Util.Block.DIAMOND_ORE, channel)
	elif origin.y < -(chunk_depth * 10) and origin.y > -(chunk_depth * 11) - 1:
		buffer.fill(Util.Block.LAVA, channel)
#	elif origin.y > -1 and origin.y < 16:
#		if rng.randi_range(0, 3) == 3:
#			_create_tree(buffer, randi_range(2, 7))


func _create_tree(buffer: VoxelBuffer, base: int) -> void:
	# The base of the tree is the x,z location of the trunk
	# Base must be >= 2 
	# Create trunk
	buffer.set_voxel(5, base, 0, base)
	buffer.set_voxel(5, base, 1, base)
	buffer.set_voxel(5, base, 2, base)
	
	# Add base leaves
	buffer.fill_area(6, Vector3i(base-2, 3, base-2), Vector3i(base+3, 5, base+3))
	buffer.fill_area(6, Vector3i(base-1, 5, base-1), Vector3i(base+2, 6, base+2))

	# Add top leaves
	buffer.set_voxel(6, base, 6, base)
	buffer.set_voxel(6, base, 6, base-1)
	buffer.set_voxel(6, base+1, 6, base)
	buffer.set_voxel(6, base-1, 6, base)
	buffer.set_voxel(6, base, 6, base+1)

	# Fill in logs
	buffer.set_voxel(5, base, 3, base)
	buffer.set_voxel(5, base, 4, base)
