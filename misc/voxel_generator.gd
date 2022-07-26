extends VoxelGeneratorScript


const channel : int = VoxelBuffer.CHANNEL_TYPE
const DEFAULT_WORLD_SEED = 123456

var world_seed: int


func _init(p_world_seed=DEFAULT_WORLD_SEED) -> void:
	world_seed = p_world_seed


func _get_used_channels_mask() -> int:
	return 1 << channel


func _generate_block(buffer: VoxelBuffer, origin: Vector3i, lod: int) -> void:
	if lod != 0:
		return
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	_generate_plains(buffer, origin)
	if origin.x > 100:
		if origin.y < 0 and origin.y > -17:
			buffer.fill_area(Util.Block.SAND, Vector3i.ZERO, Vector3i(16,16,16))
	if origin.z > 100:
		if origin.y < 0 and origin.y > -17:
			buffer.fill_area(Util.Block.WATER, Vector3i.ZERO, Vector3i(16,16,16))
# Very crappy trees!!!!!
	if origin.z < 100 and origin.x < 100:
		if origin.y > -1 and origin.y < 16:
			if rng.randi_range(0, 3) == 3:
				_create_tree(buffer, randi_range(2, 7))



func _generate_plains(buffer: VoxelBuffer, origin: Vector3i) -> void:
	const chunk_depth = 16

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
