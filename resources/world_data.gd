extends Resource
class_name WorldData

const DEFAULT_WORLD_SEED = 123456

# In game "seconds". This is equivalent to 1/60th of a real second.
@export var seconds = 0
@export var world_seed = 123456


func _init(p_world_seed = DEFAULT_WORLD_SEED) -> void:
	world_seed = p_world_seed
