extends Node

@onready
var camera = get_parent()
@onready
var terrain = get_node("../../VoxelTerrain")
var voxel_tool: VoxelTool = null

func _ready():
	voxel_tool = terrain.get_voxel_tool()
	voxel_tool.channel = VoxelBuffer.CHANNEL_TYPE
	

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("place"):
		voxel_tool.mode = VoxelTool.MODE_SET
		var result = _get_pointed_voxel() 
		if result != null:
			voxel_tool.set_voxel(result.position, 1)
	elif Input.is_action_just_pressed("break"):
		voxel_tool.mode = VoxelTool.MODE_REMOVE
		var result = _get_pointed_voxel() 
		if result != null:
			voxel_tool.set_voxel(result.position, 0)


func _get_pointed_voxel() -> VoxelRaycastResult:
	var origin = camera.get_global_transform().origin
	var forward = -camera.get_transform().basis.z.normalized()
	var result: VoxelRaycastResult = voxel_tool.raycast(origin, forward)
	return result
