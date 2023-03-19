extends CharacterBody3D

var material := preload("res://assets/models/zombie/material_0.tres")

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if is_on_wall():
		velocity.y = JUMP_VELOCITY
	move_and_slide()
