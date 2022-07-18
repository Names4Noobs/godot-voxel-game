extends Node


var start_position: Vector3i
var voxel_tool: VoxelTool = null
var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")
var item_drop := preload("res://entities/item_drop.tscn")
var break_particles := preload("res://misc/block_break_particles.tscn")
var block_entity := preload("res://entities/block_entity.tscn")

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
	voxel_tool = terrain.get_voxel_tool()
	voxel_tool.channel = VoxelBuffer.CHANNEL_TYPE
	voxel_tool.value = 1
	break_timer.one_shot = true


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("place"):
		var obj = _get_pointed_entity()
		var result = _try_to_interact(obj)
		if result != true:
			# NOTE: Placing is done through the item class currently
			item.secondary_action()

	elif Input.is_action_pressed("break"):
		if !break_timer.is_stopped():
			return
		var obj = _get_pointed_entity()
		if obj != null:
			var answer = _try_to_damage(obj)
			if answer == true:
				return
		voxel_tool.mode = VoxelTool.MODE_REMOVE
		var result = _get_pointed_voxel()
		if result != null:
			if break_timer.is_stopped():
				var voxel = voxel_tool.get_voxel(result.position)
				break_timer.wait_time = Util.items[voxel].hardness
				break_timer.start()
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


func _create_drop_at_location(pos: Vector3i, vox_id: int) -> void:
	var mats = voxel_library.get_materials()
	var drop = item_drop.instantiate()
	
	drop.position = pos
	drop.position.y += .5
	drop.position.x += .5
	drop.position.z += .5
	drop.get_child(0).material = mats[vox_id-1]
	add_child(drop)


func _create_particle_at_location(pos: Vector3i, vox_id: int) -> void:
	var mats = voxel_library.get_materials()
	var particles = break_particles.instantiate()
	particles.position = pos
	particles.emitting = true
	particles.position.y += .5
	particles.position.x += .5
	particles.draw_pass_1.material = mats[vox_id-1]
	add_child(particles)


func _try_to_interact(obj: Object) -> bool:
	if obj == null:
		return false
	if obj.has_method("interact"):
		obj.call_deferred("interact")
		return true
	return false

func _try_to_damage(obj: Object, amount: int = 10) -> bool:
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
	_create_drop_at_location(pos, vox_id)
	voxel_tool.do_point(pos)


func place_block(voxel_id: int) -> void:
	voxel_tool.value = voxel_id
	voxel_tool.mode = VoxelTool.MODE_SET
	var result = _get_pointed_voxel() 
	if result != null:
		inventory.remove_amount(1)
		Signals.emit_signal("item_amount_changed")
		# NOTE: To properly place a voxel you have to use the 
		# previous position instead of the position for some reason.
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


func _drop_item(item_data: ItemData, amount: int, use_sprite: bool=true) -> void:
	var drop = item_drop.instantiate()
	var head_basis = head.get_global_transform().basis
	var forward = -head_basis.z
	drop.item = item_data
	drop.item_count = amount
	drop.position = head.get_global_position() + (forward*2)
	drop.get_node("Sprite3D").texture = item_data.texture
	drop.use_sprite = use_sprite
	add_child(drop)


func _create_explosion(position: Vector3i, radius: int) -> void:
	voxel_tool.mode = VoxelTool.MODE_REMOVE
	voxel_tool.do_sphere(position, radius)
	print("boom!")

func _get_block_underneath() -> VoxelRaycastResult:
	var origin = camera.get_global_transform().origin
	var down = -camera.get_transform().basis.y.normalized()
	# NOTE: The distance parameter may need tweeked in the future to get accurate 
	# fall distance
	var result: VoxelRaycastResult = voxel_tool.raycast(origin, down, 2.5)
	return result


func _on_player_falling() -> void:
	var result = _get_block_underneath()
	if result != null:
		start_position = result.position


func _on_player_fell() -> void:
	var result = _get_block_underneath()
	if result != null:
		# NOTE: This calculation is not always acurate 
		var distance = start_position.y - result.position.y
		#print("You fell:" + str(distance))
		if distance > 8:
			Signals.emit_signal("player_damage", 50)
