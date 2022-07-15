extends Resource
class_name ItemData


@export_enum(BLOCK, CONSUMABLE, BLOCK_ENTITY) var type = 0
@export var display_name := "Default Block"
@export var texture: Texture2D = preload("res://assets/textures/block/dirt.png")

# Block specific data
@export var voxel_id := 1
@export var hardness := 1

