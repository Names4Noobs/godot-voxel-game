class_name BlockData
extends Resource


const DEFAULT_HARDNESS := 0.5
const DEFAULT_FRICTION := 1.0

@export_enum(NONE, SWORD, PICKAXE, AXE, SHOVEL, HOE) var tool_type = 0
@export var name: String = ""
@export var drop_item: Resource
@export var can_break := true
@export var voxel_id: int
@export var hardness: float = DEFAULT_HARDNESS
@export var friction: float = DEFAULT_FRICTION


