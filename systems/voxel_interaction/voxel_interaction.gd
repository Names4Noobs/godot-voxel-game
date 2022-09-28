extends Node

var previous_voxel: int
var voxel_tool: VoxelTool = null

var item_drop := preload("res://entities/ItemDrop/item_drop.tscn")
var block_entity := preload("res://entities/BlockEntity/block_entity.tscn")
var projectile_entity := preload("res://entities/Projectile/projectile.tscn")

@export_node_path(Camera3D) var camera_path
@export_node_path(Node3D) var head_path
@export_node_path(RayCast3D) var raycast_path
@export_node_path(VoxelTerrain) var terrain_path

# TODO: Make voxel interaction work with multiple cameras.
@onready var camera: Camera3D = get_node(camera_path)
@onready var head: Node3D = get_node(head_path)
@onready var terrain: VoxelTerrain = get_node(terrain_path)
@onready var raycast: RayCast3D = get_node(raycast_path)

@onready var break_timer: Timer = $BreakTimer
@onready var inventory: Resource
@onready var item_node: Node = $Item
@onready var audio_manager: Node = $Audio

func _ready() -> void:
	break_timer.connect("timeout", _on_timer_timeout)
	Signals.connect("place_block", place_block)
	Signals.connect("drop_item", _drop_item)
	Signals.connect("place_block_entity", place_block_entity)
	Signals.connect("create_explosion", _create_explosion)
	Signals.connect("player_damage_pointed_entity", _damage_pointed_entity)
	Signals.connect("eat_food", _on_player_eat_food)
	Signals.connect("fire_projectile", _fire_projectile)
	
	voxel_tool = terrain.get_voxel_tool()
	voxel_tool.set_channel(VoxelBuffer.CHANNEL_TYPE)
	voxel_tool.value = 1
	
	break_timer.one_shot = true
	
	inventory = Util.get_player_inventory()


func _physics_process(_delta: float) -> void:
	var pointed_voxel = _get_pointed_voxel()
	if pointed_voxel != null:
		var pos = pointed_voxel.position
		var vox_id = voxel_tool.get_voxel(pos)
		Signals.emit_signal("selected_block_changed", pointed_voxel.position, Util.blocks[vox_id])
	if Input.is_action_just_pressed("place"):
		var obj = _get_pointed_entity()
		var result = _try_to_interact(obj)
		if result != true:
			# NOTE: Placing is done through the item class currently
			if !inventory.is_selected_slot_empty():
				item_node.secondary_action()

	elif Input.is_action_just_pressed("break"):
		item_node.primary_action()
	elif Input.is_action_pressed("break"):
		if !break_timer.is_stopped():
			var r = _get_pointed_voxel()
			if r != null:
				var v = voxel_tool.get_voxel(r.position)
				if v != previous_voxel and previous_voxel != null:
					_start_mine_timer(v)
					return
			return
		if pointed_voxel != null:
			var voxel = voxel_tool.get_voxel(pointed_voxel.position)
			_start_mine_timer(voxel)
	elif Input.is_action_just_released("break"):
		break_timer.stop()


func _get_pointed_entity() -> Object:
	var ray_length = 16
	var center_screen = Util._get_viewport_center()
	var origin = camera.project_ray_origin(center_screen)
	var target = origin + camera.project_ray_normal(center_screen) * ray_length
	var space_state: PhysicsDirectSpaceState3D = get_viewport().find_world_3d().get_direct_space_state()
	var query := PhysicsRayQueryParameters3D.new()
	query.from = origin
	query.to = target
	var result = space_state.intersect_ray(query)
	if result.has("position") and result.has("collider"):
		if result.get("collider") is RigidBody3D:
			return result.get("collider")
	return null


func _get_pointed_voxel() -> VoxelRaycastResult:
	var origin = camera.get_global_transform().origin
	# NOTE: This can only work for the character camera. Currently,
	# the parent node is used as a pivot so that the character rotates independently 
	# of the body. 
	var forward = -camera.get_parent().get_transform().basis.z.normalized()
	var result: VoxelRaycastResult = voxel_tool.raycast(origin, forward)
	return result


func _try_to_interact(obj: Object) -> bool:
	if obj == null:
		return false
	if obj.has_method("interact"):
		obj.call_deferred("interact")
		return true
	return false


func _try_to_damage(obj: Object, amount: int) -> bool:
	if obj == null:
		return false
	if obj.has_method("damage"):
		obj.call_deferred("damage", amount)
		return true
	return false


func _start_mine_timer(voxel_id: int) -> void:
	var break_time = item_node.calculate_block_break_time(voxel_id)
	break_timer.wait_time = break_time
	break_timer.start()
	previous_voxel = voxel_id


func _on_timer_timeout() -> void:
	var result = _get_pointed_voxel()
	if result != null:
		_break_block(result.position)


func _break_block(pos: Vector3i) -> void:
	var vox_id = voxel_tool.get_voxel(pos)
	_drop_item(Util.items[vox_id], pos, 1, true)
	voxel_tool.mode = VoxelTool.MODE_REMOVE
	voxel_tool.do_point(pos)
	


func place_block(voxel_id: int) -> void:
	voxel_tool.value = voxel_id
	voxel_tool.mode = VoxelTool.MODE_SET
	var result = _get_pointed_voxel() 
	if result != null:
		voxel_tool.do_point(result.previous_position)
		audio_manager.get_node("PlaceBlock").play()

func place_block_entity(type: int) -> void:
	var result = _get_pointed_voxel()
	if result != null:
		var entt = block_entity.instantiate()
		entt.type = type
		entt.position = result.position
		entt.position.y += .5
		entt.position.x += .5
		entt.position.z += .5
		add_child(entt)


func _drop_item(item_data: ItemData, location: Vector3, amount: int, use_location: bool) -> void:
	var drop = item_drop.instantiate()
	drop.item = item_data
	drop.item_count = amount
	if !use_location:
		var head_basis = head.get_global_transform().basis
		var forward = -head_basis.z
		drop.position = head.get_global_position() + (forward*2)
	else:
		drop.position = location
		drop.position.y += 0.5
		drop.position.x += 0.5
		drop.position.z += 0.5
	add_child(drop)


func _create_explosion(position: Vector3i, radius: int) -> void:
	voxel_tool.mode = VoxelTool.MODE_REMOVE
	voxel_tool.value = 0
	voxel_tool.do_sphere(position, radius)


func _get_block_underneath() -> VoxelRaycastResult:
	var origin = camera.get_global_transform().origin
	var down = -camera.get_transform().basis.y.normalized()
	# NOTE: The distance parameter may need tweaked in the future to get accurate 
	# fall distance
	var result: VoxelRaycastResult = voxel_tool.raycast(origin, down, 2.5)
	return result


func _damage_pointed_entity(amount: int) -> void:
	var obj = _get_pointed_entity()
	if obj != null:
		var answer = _try_to_damage(obj, amount)
		if answer == true:
			return


func _on_player_eat_food(_food: Resource) ->  void:
	Signals.emit_signal("player_heal", 10)
	audio_manager.get_node("EatSFX").play()


func _fire_projectile(_projectile_id: int) -> void:
	var forward = -camera.get_parent().get_transform().basis.z.normalized()
	var scene  = projectile_entity.instantiate()
	scene.direction = forward
	scene.position = camera.get_parent().get_global_position() + (forward * 2)
	add_child(scene)
