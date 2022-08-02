## Data relating to in game blocks
class_name BlockData
extends Resource


const DEFAULT_HARDNESS := 0.5
const DEFAULT_FRICTION := 1.0

@export_enum(NONE, SWORD, PICKAXE, AXE, SHOVEL, HOE) var tool_type = 0
@export var voxel_id: int
@export var hardness: float
@export var friction: float


func _init(p_id: int, p_hardness: float = DEFAULT_HARDNESS, p_friction: float = DEFAULT_FRICTION, p_type: int = Util.ToolType.NONE) -> void:
	voxel_id = p_id
	hardness = p_hardness
	friction = p_friction 
	tool_type = p_type
