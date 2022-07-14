extends RigidDynamicBody3D
class_name ItemDropEntity

var random_factor: float
var use_sprite := false:
	set(v):
		if $CSGBox3D != null:
			$CSGBox3D.visible = !$CSGBox3D.visible
			if $Sprite3D != null:
				$Sprite3D.visible = !$Sprite3D.visible
		use_sprite = v

func _ready() -> void:
	random_factor = randf_range(.5, 2.0)
	lock_rotation = true


func _physics_process(_delta: float) -> void:
	rotate_x(.01 * random_factor)
	rotate_y(.01 * random_factor)
