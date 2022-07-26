# NOTE: This character controller should use a finite state machine system eventually.
# Complex states, like sprinting while swimming require this.
extends CharacterBody3D


const SPEED = 9.5
const SPRINT_SPEED = 14.5
const JUMP_VELOCITY = 5
const SPRINT_JUMP_VELOCITY = 6


var is_sprinting = false
var is_crouching = false
var is_falling = false

var data: Resource

@onready var head: Node3D = $Node3D

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	collision_layer = 2
	collision_mask = 1
	data = PlayerData.new()
	data.stats.health = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_pressed("sprint") and data.stats.can_sprint:
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
		if !is_sprinting:
			velocity.y = JUMP_VELOCITY
		else:
			velocity.y = SPRINT_JUMP_VELOCITY
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	
	var new_basis = head.basis.rotated(head.basis.x, -head.basis.get_euler().x)
	var direction := (new_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if !is_sprinting:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			data.stats.stamina -= 1
			velocity.x = direction.x * SPRINT_SPEED
			velocity.z = direction.z * SPRINT_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
