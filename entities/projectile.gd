extends CharacterBody3D


const SPEED = 20.0

var direction: Vector3
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	if direction == null:
		return
	if not is_on_floor():
		velocity.y -= (gravity/4) * delta
	if is_on_floor():
		queue_free()
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	move_and_slide()


func does_damage() -> bool:
	return true
