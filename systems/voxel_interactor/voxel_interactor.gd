extends Node

@export var head: Node3D
@export var player_camera: Camera3D
@export var inventory: Inventory

var voxel_tool: VoxelTool = null


func _ready() -> void:
	voxel_tool = %VoxelTerrain.get_voxel_tool()
	voxel_tool.value = 0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("primary_action"):
		_break_pointed_voxel()
	elif event.is_action_released("secondary_action"):
		_place_selected_voxel()


func _place_selected_voxel() -> void:
	if voxel_tool == null or inventory == null:
		return
	if not inventory.get_selected_slot().is_empty():
		var block_id = inventory.get_selected_slot().item.block_id
		var block := Game.get_block(block_id)
		if block != null:
			voxel_tool.value = Game.get_block(block_id).voxel_id
			var result := _get_pointed_voxel()
			if result != null:
				_place_voxel(result.previous_position)
				inventory.get_selected_slot().amount -= 1
				Game.emit_signal("block_placed")

func _break_pointed_voxel() -> void:
	if voxel_tool == null:
		return
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
