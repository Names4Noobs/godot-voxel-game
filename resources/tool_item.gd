class_name ToolItem
extends Item

var tool_category: int
var mining_speed_multiplier: float
var tier: int
var damage_multiplier := 1.0

func _init(p_item_id: StringName, p_tool_category: int) -> void:
	super(p_item_id)
	tool_category = p_tool_category
	stack_size = 1
