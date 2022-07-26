extends Resource
class_name ItemData


@export_enum(BLOCK, CONSUMABLE, BLOCK_ENTITY, PROJECTILE, NONE) var type = 0
@export var display_name := "Default Block"
@export var texture: Texture2D = null#preload("res://assets/textures/block/dirt.png")
@export var max_stack_size := 64

# Is the item drop displayed as a sprite or a 3D model
@export var is_drop_sprite = false


# Block specific data
# TODO: Make this into a child resource of item
@export var voxel_id := 1
# NOTE: Right now this is the break timer directly.
# In the future, their will be multipliers and stuff so the base value 
# may need to change
@export var hardness := 0.5

# Consumable specific data
#@export var consume_time := 0.5

# Block entity data
@export_enum(CRAFTING, FURNACE, TNT) var entity_type = 0

# Tool item data

