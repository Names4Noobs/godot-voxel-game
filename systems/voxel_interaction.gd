extends Node

signal selected_new_voxel(new_id: int)
signal placed_voxel(pos: Vector3i, v_name)
signal broke_voxel(pos: Vector3i, v_name)

@onready var inventory: Node = $Inventory


var voxel_tool: VoxelTool = null
var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")
var item_drop = preload("res://entities/item_drop.tscn")
var break_particles = preload("res://misc/block_break_particles.tscn")
@export var break_time := 0.5

# TODO: Make voxel interaction work with multiple cameras.
@onready var camera: Camera3D = get_node("../CharacterBody3D/Node3D/Camera3D") #get_viewport().get_camera_3d()
@onready var terrain: VoxelTerrain = $%VoxelTerrain
@onready var raycast: RayCast3D = get_node("../CharacterBody3D/Node3D/RayCast3D")
@onready var break_timer: Timer = $BreakTimer
var selected_voxel := 1:
	get: return selected_voxel
	set(v):
		selected_voxel = clamp(v, 1, voxel_library.voxel_count - 1)
		emit_signal("selected_new_voxel", selected_voxel)
		if voxel_tool != null:
			voxel_tool.value = selected_voxel


func _ready():
	voxel_tool = terrain.get_voxel_tool()
	voxel_tool.channel = VoxelBuffer.CHANNEL_TYPE
	voxel_tool.value = selected_voxel
	break_timer.wait_time = break_time
	break_timer.one_shot = true


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("place"):
		# placing is done through the item class
		inventory.get_selected_item().secondary_action()
		
		# Later, this should be done in the item class as well
		# Check for entity to interact with
		var obj = _get_pointed_entity()
		_try_to_interact(obj)

	elif Input.is_action_pressed("break"):
		if !break_timer.is_stopped():
			return
		voxel_tool.mode = VoxelTool.MODE_REMOVE
		var result = _get_pointed_voxel()
		if result != null:
			if break_timer.is_stopped():
				break_timer.start()
				#print("started the timer")
	elif Input.is_action_just_released("break"):
		break_timer.stop()





func _get_pointed_entity() -> Object:
	var ray_length = 16
	var center_screen = _get_viewport_center()
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
	#_create_particle_at_location(pos, vox_id)
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


func _try_to_interact(obj: Object) -> void:
	if obj == null:
		return
	if obj.has_method("interact"):
		obj.call_deferred("interact")


func _get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport().global_canvas_transform
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport().get_visible_rect().size / scale / 2


func _on_timer_timeout() -> void:
	#print("stopped")
	var result = _get_pointed_voxel()
	if result != null:
		_break_block(result.position)


func _break_block(pos: Vector3i) -> void:
	var vox_id = voxel_tool.get_voxel(pos)
	emit_signal("broke_voxel", pos, get_voxel_name(selected_voxel))
	_create_drop_at_location(pos, vox_id)
	voxel_tool.do_point(pos)


func place_block(voxel_id: int) -> void:
	selected_voxel = voxel_id
	voxel_tool.mode = VoxelTool.MODE_SET
	var result = _get_pointed_voxel() 
	if result != null:
		emit_signal("placed_voxel", result.position, get_voxel_name(selected_voxel))
		voxel_tool.do_point(result.position)

func get_voxel_texture(vox_id: int) -> void:
	pass

func get_voxel_name(vox_id: int) -> StringName:
	return voxel_library.get_voxel(vox_id).voxel_name
