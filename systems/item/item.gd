extends Node
class_name Item
@icon("res://assets/textures/item/beef.png")


@export var data: Resource = Util.dirt_item


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
	var break_time = Util.items[voxel_id].hardness
	if data is ToolItemData:
		match data.tool_type:
			Util.ToolType.PICKAXE:
				if is_pickaxe_block(voxel_id):
					return break_time / data.efficiency
				continue
			Util.ToolType.AXE:
				if is_axe_block(voxel_id):
					return break_time / data.efficiency
				continue
			Util.ToolType.SHOVEL:
				if is_shovel_block(voxel_id):
					return break_time / data.efficiency
				continue
			_:
				return break_time
	return break_time


# TODO: Make this logic a part of item data
func is_shovel_block(voxel_id: int) -> bool:
	match voxel_id:
		Util.Block.GRASS:
			return true
		Util.Block.DIRT:
			return true
		Util.Block.SAND:
			return true
	return false

func is_pickaxe_block(voxel_id: int) -> bool:
	match voxel_id:
		Util.Block.STONE:
			return true
		Util.Block.COAL_ORE:
			return true
		Util.Block.IRON_ORE:
			return true
		Util.Block.GOLD_ORE:
			return true
		Util.Block.DIAMOND_ORE:
			return true
	return false


func is_axe_block(voxel_id: int) -> bool:
	if voxel_id == Util.Block.LOG:
		return true
	return false

