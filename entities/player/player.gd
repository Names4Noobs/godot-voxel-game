class_name Player
extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const INVENTORY_SLOTS = 36

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_input_disabled := false

var voxel_terrain: VoxelTerrain
var inventory: Inventory

@onready var head := $CameraHead
@onready var camera_switcher := $CameraSwitcher
@onready var hotbar := $Hotbar
@onready var voxel_interactor := $VoxelInteractor
@onready var item_dropper := $ItemDropper
@onready var entity_interactor := $EntityInteractor


func _ready() -> void:
	# TODO: More checks need to be made if the input can be enabled 
	# such as if the client is in freecam mode
	Events.connect("player_menu_opened", func(): is_input_disabled = true)
	Events.connect("player_menu_closed", func(): is_input_disabled = false)
	if camera_switcher:
		camera_switcher.connect("freecam_toggled", func(v): is_input_disabled = v)
	if voxel_terrain:
		voxel_interactor.player = self
		voxel_interactor.voxel_tool = voxel_terrain.get_voxel_tool()
		voxel_interactor.voxel_library = voxel_terrain.mesher.library
	_give_items()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if is_input_disabled:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		move_and_slide()
		return

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var new_basis: Basis = head.basis.rotated(head.basis.x, -head.basis.get_euler().x)
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (new_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func get_inventory() -> Inventory:
	if is_instance_valid(inventory):
		return inventory
	return null

func get_voxel_terrain() -> VoxelTerrain:
	if is_instance_valid(voxel_terrain):
		return voxel_terrain
	return null

func get_camera_head() -> Node3D:
	return head

func get_camera_switcher() -> CameraSwitcher:
	return camera_switcher

func get_hotbar() -> Hotbar:
	return hotbar

func _give_items() -> void:
	inventory.add_item_stack(ItemStack.create_full_stack("wooden_sword"))
	inventory.add_item_stack(ItemStack.create_full_stack("wooden_pickaxe"))
	inventory.add_item_stack(ItemStack.create_full_stack("wooden_axe"))
	inventory.add_item_stack(ItemStack.create_full_stack("wooden_shovel"))
	inventory.add_item_stack(ItemStack.create_full_stack("wooden_hoe"))
	inventory.add_item_stack(ItemStack.create_full_stack("leaf_block"))
	inventory.add_item_stack(ItemStack.create_full_stack("chest"))
