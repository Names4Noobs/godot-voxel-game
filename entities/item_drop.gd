extends RigidDynamicBody3D

var random_factor: float

func _ready() -> void:
	random_factor = randf_range(.5, 2.0)
	lock_rotation = true


func _physics_process(_delta: float) -> void:
	rotate_x(.01 * random_factor)
	rotate_y(.01 * random_factor)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		queue_free()
