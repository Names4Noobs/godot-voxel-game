extends RigidDynamicBody3D

var random_factor: float

func _ready() -> void:
	random_factor = randf_range(.5, 2.0)
	custom_integrator = true


func _physics_process(_delta: float) -> void:
	rotate_x(.01 * random_factor)
	rotate_y(.01 * random_factor)
	pass

# I have no idea how to properly use this. 
# Once I do, the item's rotation won't be jank.
func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	#state.apply_torque_impulse(Vector3(0,0.1,0))
	#state.apply_torque(Vector3(5, 0, 0.0))
	#state.add_constant_central_force(Vector3(0.0, 5.0, 0.0))
	#state.set_transform(transform.basis.rotated(Vector3.RIGHT, 0.01))
	state.integrate_forces()
	pass



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		queue_free()
