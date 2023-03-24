extends Node

const BREAK_DURATION := 0.5
var duration := BREAK_DURATION
var previous_result: VoxelRaycastResult
var changed_block := false

var player: Player:
	set(v):
		player = v
		if player:
			hotbar = player.get_hotbar()
			head = player.get_camera_head()
var hotbar: Hotbar
var head: Node3D:
	set(v):
		head = v
		player_camera = head.get_node("PlayerCamera3D")
var player_camera: Camera3D
var voxel_tool: VoxelTool:
	set(v):
		voxel_tool = v
		if voxel_tool:
			voxel_tool.channel = VoxelBuffer.CHANNEL_TYPE
			voxel_tool.value = 0
			voxel_tool.eraser_value = 0
var voxel_library: VoxelBlockyLibrary


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if not player:
		return
	if player.is_input_disabled:
		return
	_check_if_changed_block()
	
	if Input.is_action_pressed("primary_action"):
		if not changed_block:
			duration -= delta
			if duration < 0:
				_break_pointed_voxel()
				duration = BREAK_DURATION
		else:
			duration = BREAK_DURATION
	elif Input.is_action_just_released("primary_action"):
		duration = BREAK_DURATION


func _unhandled_input(event: InputEvent) -> void:
	if not player:
		return
	if player.is_input_disabled:
		return
	elif event.is_action_released("secondary_action"):
		_place_selected_voxel()


func _place_selected_voxel() -> void:
	if not voxel_tool or not hotbar:
		return
	var selected_slot := hotbar.get_selected_slot()
	if not selected_slot.is_empty():
		if selected_slot.item is BlockItem:
			var block_id = hotbar.get_selected_slot().item.block_id
			var block := Game.get_block(block_id)
			if block != null:
				voxel_tool.value = Game.get_block(block_id).voxel_id
				var result := get_pointed_voxel()
				if result != null:
					_place_voxel(result.previous_position)
					hotbar.get_selected_slot().amount -= 1
					Events.emit_signal("block_placed")
		elif selected_slot.item is BlockEntityItem:
			var entity_scene: PackedScene = hotbar.get_selected_slot().item.entity_scene
			if entity_scene != null:
				var result := get_pointed_voxel()
				if result != null:
					var scene = entity_scene.instantiate()
					scene.position = Vector3(result.previous_position)
					hotbar.get_selected_slot().amount -= 1 
					Game.get_world().add_child(scene)
					scene.global_position.x += 0.5
					scene.global_position.y += 0.5
					scene.global_position.z += 0.5


func _break_pointed_voxel() -> void:
	if not voxel_tool or not voxel_library:
		return
	var result := get_pointed_voxel()
	if result:
		var block_id := voxel_library.get_voxel(voxel_tool.get_voxel(result.position))
		var block_data = Game.get_block(block_id.voxel_name)
		if block_data.can_break:
			var drop = Game.world.create_item_drop(result.position, ItemStack.new(Game.get_item("%s_block" % block_id.voxel_name), 1))
			drop.global_position.x += 0.5
			drop.global_position.y += 0.5
			drop.global_position.z += 0.5
			_break_voxel(result.position)


func _place_voxel(position: Vector3i) -> void:
	voxel_tool.mode = VoxelTool.MODE_ADD
	voxel_tool.do_point(position)


func _break_voxel(position: Vector3i) -> void:
	voxel_tool.mode = VoxelTool.MODE_REMOVE
	voxel_tool.do_point(position)


func _check_if_changed_block() -> void:
	if not previous_result:
		var r = get_pointed_voxel()
		if r:
			previous_result = r
			return
	var result = get_pointed_voxel()
	if result:
		if previous_result.position != result.position:
			changed_block = true
		else:
			changed_block = false
		previous_result = result


func get_pointed_voxel() -> VoxelRaycastResult:
	var origin = player_camera.get_global_transform().origin
	var forward = -head.basis.z.normalized()
	var result: VoxelRaycastResult = voxel_tool.raycast(origin, forward)
	return result


func get_pointed_block_data() -> Block:
	var result := get_pointed_voxel()
	if result:
		var block_id := voxel_library.get_voxel(voxel_tool.get_voxel(result.position))
		var block_data = Game.get_block(block_id.voxel_name)
		return block_data
	return null


func get_voxel_below() -> VoxelRaycastResult:
	var origin = player_camera.get_global_transform().origin
	var forward = Vector3.DOWN
	var result: VoxelRaycastResult = voxel_tool.raycast(origin, forward)
	return result
