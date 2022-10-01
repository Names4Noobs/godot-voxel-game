class_name ItemData
extends Resource

@export_enum(BLOCK, CONSUMABLE, BLOCK_ENTITY, PROJECTILE, NONE) var type = 0
@export var name := "Default Block"
@export var texture: Texture2D = null
@export var max_stack_size := 64


# TODO: Redesign block entities
#@export_enum(CRAFTING, FURNACE, TNT) var entity_type = 0
