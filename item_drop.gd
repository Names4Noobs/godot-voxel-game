extends RigidDynamicBody3D

var random_factor: float
var color

func _init(p_color: Color = Color.GHOST_WHITE) -> void:
	color = p_color 

func _ready() -> void:
	random_factor = randf_range(.5, 2.0)


func _physics_process(delta: float) -> void:
	rotate_x(.01 * random_factor)
	rotate_y(.01 * random_factor)


