extends CharacterBody3D


const SPEED := 5.0
const JUMP_VELOCITY := 7.5

# TODO: Match the player's hitbox with the block placement collision aabb
## Size of the AABB
var size := Vector3(0.9, 1.9, 0.9)

var gamemode := World.Gamemode.SURVIVAL

# TODO: Instead of setting the terrain, we will give it a reference to the world
# This is so we can do things like check the gamemode
# This design should be fine; the player doesn't make sense without the world
var terrain: VoxelTerrain:
	set = set_terrain
var selected_block := 1:
	set = set_selected_block


var _tool: VoxelToolTerrain
var _block_count: int

@onready var head := $Head as Node3D
@onready var camera := $Head/Camera3D as Camera3D


func _physics_process(delta: float) -> void:
	if terrain and _tool:
		if Input.is_action_just_pressed(&"break"):
			var forward := -camera.get_transform().basis.z.normalized()
			var result := _tool.raycast(camera.global_position, forward)
			if result:
				_tool.mode = VoxelTool.MODE_REMOVE
				_tool.do_point(result.position)
				_tool.mode = VoxelTool.MODE_SET
		elif Input.is_action_just_pressed(&"place"):
			var forward := -camera.get_transform().basis.z.normalized()
			var result := _tool.raycast(camera.global_position, forward)
			if result:
				if block_collides(result.previous_position):
					return
				_tool.do_point(result.previous_position)
		elif Input.is_action_just_pressed(&"scroll_up"):
			selected_block += 1
		elif Input.is_action_just_pressed(&"scroll_down"):
			selected_block -= 1
		elif Input.is_action_just_pressed(&"select_hotbar_1"):
			selected_block = 1
		elif Input.is_action_just_pressed(&"select_hotbar_2"):
			selected_block = 2
		elif Input.is_action_just_pressed(&"select_hotbar_3"):
			selected_block = 3
		elif Input.is_action_just_pressed(&"select_hotbar_4"):
			selected_block = 4
		elif Input.is_action_just_pressed(&"select_hotbar_5"):
			selected_block = 5
		elif Input.is_action_just_pressed(&"select_hotbar_6"):
			selected_block = 6
		elif Input.is_action_just_pressed(&"select_hotbar_7"):
			selected_block = 7
		elif Input.is_action_just_pressed(&"select_hotbar_8"):
			selected_block = 8
		elif Input.is_action_just_pressed(&"select_hotbar_9"):
			selected_block = 9
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 2 * delta

	# Handle jump.
	if Input.is_action_just_pressed(&"ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_backward")
	var camera_rotation := camera.basis.get_euler()
	# We don't want to factor in the pitch of the camera
	camera_rotation.x = 0
	var direction := (Basis.from_euler(camera_rotation) * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"toggle_inventory"):
		print("TODO: Open inventory")
		# Some ideas for the inventory:
		# - h, j, k, l for selecting item when moving. 1-9 to select 
		# where it goes. If there is an item in the slot already, it will swap with it
		# I want to see how far I can get without drag and drop.
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"drop_all_items"):
		print("TODO: Drop all items")
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed(&"drop_item"):
		print("TODO: Drop item")
		get_viewport().set_input_as_handled()

# TODO: Check for unbreakable blocks like bedrock
func can_break() -> bool:
	return true 


## Does the block at position pos collide with the player hitbox?
func block_collides(pos: Vector3i) -> bool:
	# We are assuming every block is a 1^3m block
	return AABB(pos, Vector3.ONE).intersects(AABB(global_position-size/2, size))


func set_terrain(p_terrain: VoxelTerrain) -> void:
	terrain = p_terrain
	# Setup voxel tool
	_tool = terrain.get_voxel_tool()
	_tool.channel = VoxelBuffer.CHANNEL_TYPE
	_tool.mode = VoxelTool.MODE_SET
	_tool.value = selected_block
	# Get block count
	var mesher := terrain.mesher as VoxelMesherBlocky
	var library := mesher.library as VoxelBlockyLibrary
	_block_count = len(library.models)
	
	# TODO: It would be nice to use the VoxelBlockyTypeLibrary
	# However, that type seems to be unstable and we don't need it right now
	#var library := mesher.library as VoxelBlockyTypeLibrary
	#_block_count = len(library.types) 

func set_selected_block(idx: int) -> void:
	if not terrain:
		return
	# If terrain isn't null but _block_count and _tool are, we have problems....
	assert(_block_count)
	assert(_tool)
	# NOTE: We start at idx 1 because 0 should be air
	selected_block = wrapi(idx, 1, _block_count)
	_tool.value = selected_block
