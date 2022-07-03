extends Node

var voxel_tool: VoxelTool = null
var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")

@onready var camera = get_parent()
@onready var terrain: VoxelTerrain = get_node("../../VoxelTerrain")


var selected_voxel := 1:
	get: return selected_voxel
	set(v):
		selected_voxel = clamp(v, 1, voxel_library.voxel_count - 1)


func _ready():
	voxel_tool = terrain.get_voxel_tool()
	voxel_tool.channel = VoxelBuffer.CHANNEL_TYPE


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("place"):
		voxel_tool.mode = VoxelTool.MODE_SET
		var result = _get_pointed_voxel() 
		if result != null:
			voxel_tool.set_voxel(result.position, selected_voxel)
	elif Input.is_action_just_pressed("break"):
		voxel_tool.mode = VoxelTool.MODE_REMOVE
		var result = _get_pointed_voxel() 
		if result != null:
			voxel_tool.set_voxel(result.position, 0)
	elif Input.is_action_just_released("scroll_up"):
		selected_voxel += 1
	elif Input.is_action_just_released("scroll_down"):
		selected_voxel -= 1


func _get_pointed_voxel() -> VoxelRaycastResult:
	var origin = camera.get_global_transform().origin
	var forward = -camera.get_transform().basis.z.normalized()
	var result: VoxelRaycastResult = voxel_tool.raycast(origin, forward)
	return result
