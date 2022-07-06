extends Node

signal selected_new_voxel(new_id: int)
signal placed_voxel(pos: Vector3i, v_name)
signal broke_voxel(pos: Vector3i, v_name)

var voxel_tool: VoxelTool = null
var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")
var item_drop = preload("res://item_drop.tscn")

@onready var camera = get_parent()
@onready var terrain: VoxelTerrain = $%VoxelTerrain


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


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("place"):
		voxel_tool.mode = VoxelTool.MODE_SET
		var result = _get_pointed_voxel() 
		if result != null:
			emit_signal("placed_voxel", result.position, voxel_library.get_voxel(selected_voxel).voxel_name)
			voxel_tool.do_point(result.position)
	elif Input.is_action_just_pressed("break"):
		voxel_tool.mode = VoxelTool.MODE_REMOVE
		var result = _get_pointed_voxel() 
		if result != null:
			emit_signal("broke_voxel", result.position, voxel_library.get_voxel(voxel_tool.get_voxel(result.position)).voxel_name)
			voxel_tool.do_point(result.position)
			_create_drop_at_location(result.position)
	elif Input.is_action_just_released("scroll_up"):
		selected_voxel += 1
	elif Input.is_action_just_released("scroll_down"):
		selected_voxel -= 1
	elif Input.is_action_just_pressed("select_slot1"):
		selected_voxel = 1
	elif Input.is_action_just_pressed("select_slot2"):
		selected_voxel = 2
	elif Input.is_action_just_pressed("select_slot3"):
		selected_voxel = 3


func _get_pointed_voxel() -> VoxelRaycastResult:
	var origin = camera.get_global_transform().origin
	var forward = -camera.get_transform().basis.z.normalized()
	var result: VoxelRaycastResult = voxel_tool.raycast(origin, forward)
	return result


func _create_drop_at_location(pos: Vector3i) -> void:
	var mats = voxel_library.get_materials()
	voxel_tool.get_voxel(pos)
	var drop = item_drop.instantiate()
	drop.position = pos
	drop.position.y += .5
	drop.position.x += .5
	drop.position.z += .5
	drop.get_child(0).material = mats[voxel_tool.get_voxel(pos)]
	add_child(drop)
