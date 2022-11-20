class_name ToolItemData
extends ItemData
@icon("res://assets/textures/item/diamond_pickaxe.png")


@export_enum(NONE, SWORD, PICKAXE, AXE, SHOVEL, HOE) var tool_type = 0
# TODO: Damage determines how fast a block is mined as well as how much an entity is damaged
@export var damage := 1.0
# TODO: Efficiency is a multiplier on tool damage 
@export var efficiency := 2.0


func _init() -> void:
	max_stack_size = 1
