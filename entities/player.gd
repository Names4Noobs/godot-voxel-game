# NOTE: This character controller should use a finite state machine system eventually.
# Complex states, like sprinting while swimming require this.
extends CharacterBody3D


const SPEED = 4.5
const SPRINT_SPEED = 9.5
const JUMP_VELOCITY = 5

var is_sprinting = false
var is_crouching = false
var is_falling = false

@onready var head: Node3D = $Node3D

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_pressed("sprint"):
		is_sprinting = true
	else:
		is_sprinting = false
	
	if !is_on_floor() and is_falling != true:
		is_falling = true
		Signals.emit_signal("player_falling")
	
	if is_on_floor() and is_falling == true:
		is_falling = false
		Signals.emit_signal("player_fell")
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Thank god I found this.
	# https://github.com/godotengine/godot-demo-projects/blob/b1f9f2da483d231a3cbed7eb66dd88588257f008/3d/kinematic_character/player/cubio.gd#L26
	var new_basis = head.basis.rotated(head.basis.x, -head.basis.get_euler().x)
	var direction := (new_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if !is_sprinting:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = direction.x * SPRINT_SPEED
			velocity.z = direction.z * SPRINT_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
