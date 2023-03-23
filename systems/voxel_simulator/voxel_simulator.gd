extends Node

const SIMULATION_RADIUS := 10
const VOXELS_PER_FRAME = 512

@export var enabled := true:
	set(v):
		set_physics_process(v)
		enabled = v

var voxel_tool: VoxelTool
var player: Player

func _physics_process(_delta: float) -> void:
	if not player or not voxel_tool:
		return
	var center = player.transform.origin.floor()
	var r = SIMULATION_RADIUS
	var area = AABB(center - Vector3(r, r, r), 2 * Vector3(r, r, r))
	voxel_tool.run_blocky_random_tick(area, VOXELS_PER_FRAME, _random_tick_callback)


func _random_tick_callback(voxel_position: Vector3i, value: int) -> void:
	match value:
		Game.VoxelId.GRASS:
			if _block_makes_grass_die(voxel_tool.get_voxel(voxel_position + Vector3i.UP)):
				voxel_tool.set_voxel(voxel_position, Game.VoxelId.DIRT)
			if randi_range(0, 50) == 0:
				_try_to_spread(voxel_position + Vector3i.LEFT)
				_try_to_spread(voxel_position + Vector3i.RIGHT)
				_try_to_spread(voxel_position + Vector3i.FORWARD)
				_try_to_spread(voxel_position + Vector3i.BACK)


func _try_to_spread(voxel_position: Vector3i) -> void:
	if voxel_tool.get_voxel(voxel_position) == Game.VoxelId.DIRT:
		if _block_makes_grass_die(voxel_tool.get_voxel(voxel_position + Vector3i.UP)):
			return
		voxel_tool.set_voxel(voxel_position, Game.VoxelId.GRASS)


func _block_makes_grass_die(voxel_id: int) -> bool:
	return voxel_id != Game.VoxelId.AIR and voxel_id != Game.VoxelId.LEAF
