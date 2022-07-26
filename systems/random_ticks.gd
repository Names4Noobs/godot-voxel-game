# Based off of: https://github.com/Zylann/voxelgame/blob/master/project/blocky_game/random_ticks.gd
extends Node


const SIMULATION_RADIUS = 10
const VOXELS_PER_FRAME = 512

@export var enabled := true:
	set(v):
		set_process(v)
		enabled = v

@onready var _terrain: VoxelTerrain = $%VoxelTerrain
@onready var _player: CharacterBody3D = $%CharacterBody3D
@onready var _voxel_tool: VoxelTool = _terrain.get_voxel_tool()


func _ready() -> void:
	_voxel_tool.set_channel(VoxelBuffer.CHANNEL_TYPE)


func _process(_delta: float) -> void:
	var center = _player.transform.origin.floor()
	var r = SIMULATION_RADIUS
	var area = AABB(center - Vector3(r, r, r), 2 * Vector3(r, r, r))
	_voxel_tool.run_blocky_random_tick(area, VOXELS_PER_FRAME, Callable(self, "_random_tick_callback"))
	

func _random_tick_callback(pos: Vector3, value: int) -> void:
	if value == Util.Block.GRASS:
		var above = pos + Vector3.UP
		var above_v = _voxel_tool.get_voxel(above)
		if _block_makes_grass_die(above_v):
			_voxel_tool.set_voxel(pos, Util.Block.DIRT)


func _block_makes_grass_die(v_id: int) -> bool:
	return v_id != Util.Block.AIR and v_id != Util.Block.LEAF
