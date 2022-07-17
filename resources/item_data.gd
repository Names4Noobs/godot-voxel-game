extends Resource
class_name ItemData


@export_enum(BLOCK, CONSUMABLE, BLOCK_ENTITY) var type = 0
@export var display_name := "Default Block"
@export var texture: Texture2D = preload("res://assets/textures/block/dirt.png")

# Block specific data
@export var voxel_id := 1
# NOTE: Right now this is the break timer directly.
# In the future, their will be multipliers and stuff so the base value 
# may need to change
@export var hardness := 0.5

