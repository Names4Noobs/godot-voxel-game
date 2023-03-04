extends Node

@export var head: Node3D
@export var player_camera: Camera3D

var voxel_tool: VoxelTool = null
var selected_voxel := 1

func _ready() -> void:
	voxel_tool = %VoxelTerrain.get_voxel_tool()
	voxel_tool.value = selected_voxel


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("primary_action"):
		_break_pointed_voxel()
	elif Input.is_action_just_pressed("secondary_action"):
		_place_selected_voxel()


func _place_selected_voxel() -> void:
		var result := _get_pointed_voxel()
		if result != null:
			_place_voxel(result.previous_position)


func _break_pointed_voxel() -> void:
	var result := _get_pointed_voxel()
	if result != null:
		_break_voxel(result.position) 


func _place_voxel(position: Vector3i) -> void:
	voxel_tool.mode = VoxelTool.MODE_ADD
	voxel_tool.do_point(position)


func _break_voxel(position: Vector3i) -> void:
	voxel_tool.mode = VoxelTool.MODE_REMOVE
	voxel_tool.do_point(position)


func _get_pointed_voxel() -> VoxelRaycastResult:
	var origin = player_camera.get_global_transform().origin
	var forward = -head.basis.z.normalized()
	var result: VoxelRaycastResult = voxel_tool.raycast(origin, forward)
	return result
