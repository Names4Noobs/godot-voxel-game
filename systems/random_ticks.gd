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
			return
		_grow_grass(pos)
	elif value == Util.Block.WATER:

		var meta = _voxel_tool.get_voxel_metadata(pos)
		# Water can not spread further
		if meta == 0:
			return
		var forward = pos + Vector3.FORWARD
		var back = pos + Vector3.BACK
		var left =  pos + Vector3.LEFT
		var right = pos + Vector3.RIGHT
		var forward_voxel := _voxel_tool.get_voxel(forward)
		var back_voxel := _voxel_tool.get_voxel(back) 
		var left_voxel := _voxel_tool.get_voxel(left)
		var right_voxel := _voxel_tool.get_voxel(right)
		if forward_voxel == Util.Block.AIR:
			_spread_water(forward, meta)
		elif back_voxel == Util.Block.AIR:
			_spread_water(back, meta)
		elif left_voxel == Util.Block.AIR:
			_spread_water(left, meta)
		elif right_voxel == Util.Block.AIR:
			_spread_water(right, meta)


func _block_makes_grass_die(v_id: int) -> bool:
	return v_id != Util.Block.AIR and v_id != Util.Block.LEAF


func _grow_grass(pos: Vector3) -> void:
	var left = pos + Vector3.LEFT
	var right = pos + Vector3.RIGHT
	var forward = pos + Vector3.FORWARD
	var back = pos + Vector3.BACK

	if _voxel_tool.get_voxel(left) == Util.Block.DIRT:
		if !_block_makes_grass_die(_voxel_tool.get_voxel(left + Vector3.UP)):
			_voxel_tool.set_voxel(left, Util.Block.GRASS)
	if _voxel_tool.get_voxel(right) == Util.Block.DIRT:
		if !_block_makes_grass_die(_voxel_tool.get_voxel(right + Vector3.UP)):
			_voxel_tool.set_voxel(right, Util.Block.GRASS)
	if _voxel_tool.get_voxel(forward) == Util.Block.DIRT:
		if !_block_makes_grass_die(_voxel_tool.get_voxel(forward + Vector3.UP)):
			_voxel_tool.set_voxel(forward, Util.Block.GRASS)
	if _voxel_tool.get_voxel(back) == Util.Block.DIRT:
		if !_block_makes_grass_die(_voxel_tool.get_voxel(back + Vector3.UP)):
			_voxel_tool.set_voxel(back, Util.Block.GRASS)


func _spread_water(pos: Vector3, meta) -> void:
	if meta == null:
		_voxel_tool.set_voxel_metadata(pos, 9)
	else:
		_voxel_tool.set_voxel_metadata(pos, meta - 1)
	_voxel_tool.set_voxel(pos, Util.Block.WATER)
