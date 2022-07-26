## Data relating to in game blocks
extends Resource


@export var voxel_id := -1
@export var hardness := 0.5
@export var friction := 1


func _init(p_id: int, p_hardness: float, p_friction: float) -> void:
	voxel_id = p_id
	hardness = p_hardness
	friction = p_friction 
