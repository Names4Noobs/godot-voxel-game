class_name Player
extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_input_disabled := false

@onready var head := $CameraHead

func _ready() -> void:
	Game.player = self

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
	return get_node_or_null("Inventory")
 
func get_camera_switcher() -> Node:
	return get_node_or_null("CameraSwitcher")
