extends Node
class_name Item
@icon("res://assets/textures/item/beef.png")


@export var data: Resource = null

func _ready() -> void:
	Signals.connect("changed_selected_slot", _swap_data)


func primary_action() -> void:
	if data is ToolItemData:
		match data.tool_type:
			Util.ToolType.SWORD:
				Signals.emit_signal("player_damage_pointed_entity", 25)
			_:
				Signals.emit_signal("player_damage_pointed_entity", 69)
	else:
		Signals.emit_signal("player_damage_pointed_entity", 5)


func secondary_action() -> void:
	match data.type:
		Util.ItemType.BLOCK:
			Util.get_player_inventory().remove_selected_item(1)
			Signals.emit_signal("place_block", data.voxel_id)
		Util.ItemType.CONSUMABLE:
			Util.get_player_inventory().remove_selected_item(1)
			Signals.emit_signal("eat_food", data)
		Util.ItemType.BLOCK_ENTITY:
			Util.get_player_inventory().remove_selected_item(1)
			Signals.emit_signal("place_block", data.voxel_id)
			Signals.emit_signal("place_block_entity", data.entity_type)
		Util.ItemType.PROJECTILE:
			Signals.emit_signal("fire_projectile", Util.ProjectileType.ARROW)


func calculate_block_break_time(voxel_id: int) -> float:
	var break_time = Util.blocks[voxel_id].hardness
	var block_tool_type = Util.blocks[voxel_id].tool_type
	if data is ToolItemData:
		if data.tool_type == block_tool_type:
			return break_time / data.efficiency
	return break_time


# Change item data when selected item changed
func _swap_data(slot_data: Resource, _slot_number: int) -> void:
	if not slot_data.is_empty:
		data = slot_data.item
