extends VoxelGeneratorScript


enum Biome {PLAINS, DESERT}

const channel : int = VoxelBuffer.CHANNEL_TYPE
const DEFAULT_WORLD_SEED = 123456

var world_seed: int
var _biome_noise := FastNoiseLite.new()


func _init(p_world_seed=DEFAULT_WORLD_SEED) -> void:
	world_seed = p_world_seed
	_biome_noise.seed = world_seed
	_biome_noise.frequency = 0.001


func _get_used_channels_mask() -> int:
	return 1 << channel


func _generate_block(out_buffer: VoxelBuffer, origin_in_voxels: Vector3i, lod: int) -> void:
	if lod != 0:
		return
	var block_size := int(out_buffer.get_size().x)
	var chunk_position := Vector3i(origin_in_voxels.x >> 4, origin_in_voxels.y >> 4, origin_in_voxels.z >> 4)
	
	_generate_plains(out_buffer, origin_in_voxels)

#	var biome := _get_chunk_biome(chunk_position.x, chunk_position.z)
#	match biome:
#		Biome.PLAINS:
#			_generate_plains(out_buffer, origin_in_voxels)
#		Biome.DESERT:
#			_generate_desert(out_buffer, origin_in_voxels)


func _get_chunk_biome(x: int, z: int) -> int:
	var result = _biome_noise.get_noise_2d(x * 16, z * 16)
	if result < 0:
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
	elif origin.y > -1 and origin.y < 16:
		if rng.randi_range(0, 3) == 3:
			_create_tree(buffer, randi_range(2, 7))




func _generate_desert(buffer: VoxelBuffer, origin: Vector3i) -> void:
	const chunk_depth = 16

	if origin.y < 0 and origin.y > -17:
		# Fill grass block for top layer
		buffer.fill_area(Util.Block.SAND, Vector3i(0,10,0), Vector3i(16,16,16))
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

	var rng = RandomNumberGenerator.new()
	rng.randomize()

	if origin.y > -1 and origin.y < 16:
		if rng.randi_range(0, 3) == 3:
			_create_tree(buffer, randi_range(2, 7))


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
