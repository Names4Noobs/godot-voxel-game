class_name TestGenerator
extends VoxelGeneratorScript

const CHANNEL := VoxelBuffer.CHANNEL_TYPE
# NOTE: I am assuming the size, but I think that is ok
const BLOCK_SIZE := Vector3i(16, 16, 16)

# TODO: Create voxel library subclass with this enum and 
# load the library so we change this in only one place
enum Type {
	AIR,
	STONE,
	DIRT,
	GRASS,
	BEDROCK,
	COAL,
	TNT
}



var rng := RandomNumberGenerator.new()


@export var grass_height := 1
@export var dirt_height := 3

func _init() -> void:
	rng.seed = 0


func _get_used_channels_mask() -> int:
	return 1 << CHANNEL

func _generate_block(out_buffer: VoxelBuffer, origin_in_voxels: Vector3i, lod: int) -> void:
	if lod != 0:
		return
	if origin_in_voxels.y < 0:
		if origin_in_voxels.y > -BLOCK_SIZE.y - 1:
			out_buffer.fill(Type.STONE, CHANNEL)
			out_buffer.fill_area(Type.DIRT, Vector3i(0, BLOCK_SIZE.y-dirt_height-grass_height, 0), BLOCK_SIZE - Vector3i(0, grass_height, 0))
			out_buffer.fill_area(Type.GRASS, Vector3i(0, BLOCK_SIZE.y-grass_height, 0), BLOCK_SIZE)
		elif origin_in_voxels.y < -BLOCK_SIZE.y - 1 and origin_in_voxels.y > -BLOCK_SIZE.y*4 - 1:
			out_buffer.fill(Type.STONE, CHANNEL)
			if origin_in_voxels.y > -BLOCK_SIZE.y*4 - 1 and origin_in_voxels.y < -BLOCK_SIZE.y*3 - 1:
				out_buffer.fill_area(Type.BEDROCK, Vector3i.ZERO, Vector3i(16, 1, 16))
				
			# I know there are better ways to do this, but I don't care right now
			var roll  := rng.randi_range(1, 5)
			if roll == 5:
				var tool := out_buffer.get_voxel_tool()
				tool.channel = CHANNEL
				tool.value = Type.COAL
				tool.do_sphere(Vector3.ONE * 8, 3)
			
		
