extends Node

var previous_voxel: int
var start_position = null
var voxel_tool: VoxelTool = null
#var voxel_library: VoxelBlockyLibrary = preload("res://data/terrain/voxel_library.tres")
var item_drop := preload("res://entities/ItemDrop/item_drop.tscn")
var break_particles := preload("res://misc/block_break_particles.tscn")
var block_entity := preload("res://entities/BlockEntity/block_entity.tscn")
var projectile_entity := preload("res://entities/Projectile/projectile.tscn")

# TODO: Make voxel interaction work with multiple cameras.
@onready var camera: Camera3D = get_node("../CharacterBody3D/Node3D/Camera3D")
@onready var head: Node3D = get_node("../CharacterBody3D/Node3D")
@onready var terrain: VoxelTerrain = $%VoxelTerrain
@onready var raycast: RayCast3D = get_node("../CharacterBody3D/Node3D/RayCast3D")
@onready var break_timer: Timer = $BreakTimer
@onready var inventory: Node = $Inventory
@onready var item: Node = $Inventory/Item


func _ready():
	break_timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	Signals.connect("place_block", Callable(self, "place_block"))
	Signals.connect("drop_item", Callable(self, "_drop_item"))
	Signals.connect("place_block_entity", Callable(self, "place_block_entity"))
	Signals.connect("create_explosion", Callable(self, "_create_explosion"))
	Signals.connect("player_falling", Callable(self, "_on_player_falling"))
	Signals.connect("player_fell", Callable(self, "_on_player_fell"))
	Signals.connect("player_damage_pointed_entity", Callable(self, "_damage_pointed_entity"))
	Signals.connect("eat_food", Callable(self, "_on_player_eat_food"))
	Signals.connect("fire_projectile", Callable(self, "_fire_projectile"))
	voxel_tool = terrain.get_voxel_tool()
	voxel_tool.set_channel(VoxelBuffer.CHANNEL_TYPE)
	voxel_tool.value = 1
	break_timer.one_shot = true


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("place"):
		var obj = _get_pointed_entity()
		var result = _try_to_interact(obj)
		if result != true:
			# NOTE: Placing is done through the item class currently
			if !inventory.is_selected_slot_empty():
				item.secondary_action()

	if Input.is_action_just_pressed("break"):
		item.primary_action()
	elif Input.is_action_pressed("break"):
		if !break_timer.is_stopped():
			var r = _get_pointed_voxel()
			if r != null:
				var v = voxel_tool.get_voxel(r.position)
				if v != previous_voxel and previous_voxel != null:
					_start_mine_timer(v)
					return
			return
		var result = _get_pointed_voxel()
		if result != null:
			var voxel = voxel_tool.get_voxel(result.position)
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
		if result.get("collider") is RigidDynamicBody3D:
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
		inventory.remove_amount(1)
		voxel_tool.do_point(result.previous_position)


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
	voxel_tool.do_sphere(position, radius)


func _get_block_underneath() -> VoxelRaycastResult:
	var origin = camera.get_global_transform().origin
	var down = -camera.get_transform().basis.y.normalized()
	# NOTE: The distance parameter may need tweeked in the future to get accurate 
	# fall distance
	var result: VoxelRaycastResult = voxel_tool.raycast(origin, down, 2.5)
	return result


func _on_player_falling() -> void:
	if start_position == null:
		start_position = camera.get_global_position().y


func _on_player_fell() -> void:
	var distance = int(start_position - camera.get_global_position().y)
	start_position = null
	#print("You fell:" + str(distance))
	if distance <= 0:
		return
	_damage_player_on_fall(distance)


func _damage_pointed_entity(amount: int) -> void:
	var obj = _get_pointed_entity()
	if obj != null:
		var answer = _try_to_damage(obj, amount)
		if answer == true:
			return


func _on_player_eat_food(_food: Resource) ->  void:
	Signals.emit_signal("player_heal", 10)
	get_parent().get_node("AudioStreamPlayer").play()


func _damage_player_on_fall(distance: int) -> void:
	var fall_damage := (distance-3) * 5
	Signals.emit_signal("player_damage", fall_damage)

func _start_mine_timer(voxel_id: int) -> void:
	break_timer.wait_time = item.calculate_block_break_time(voxel_id)
	break_timer.start()
	previous_voxel = voxel_id

func _fire_projectile(_projectile_id: int) -> void:
	var forward = -camera.get_parent().get_transform().basis.z.normalized()
	var scene  = projectile_entity.instantiate()
	scene.direction = forward
	scene.position = camera.get_parent().get_global_position() + (forward * 2)
	add_child(scene)
	
