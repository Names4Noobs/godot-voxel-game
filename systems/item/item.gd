extends Node
class_name Item
@icon("res://assets/textures/item/beef.png")


@export var data: Resource = Util._dirt_item


func primary_action() -> void:
		match data.type:
			Util.ItemType.SWORD:
				Signals.emit_signal("player_damage_pointed_entity", 25)
			_:
				Signals.emit_signal("player_damage_pointed_entity", 5)


func secondary_action() -> void:
	match data.type:
		Util.ItemType.BLOCK:
			Signals.emit_signal("place_block", data.voxel_id)
		Util.ItemType.CONSUMABLE:
			get_parent().remove_amount(1)
			Signals.emit_signal("eat_food", data)
		Util.ItemType.BLOCK_ENTITY:
			Signals.emit_signal("place_block", data.voxel_id)
			Signals.emit_signal("place_block_entity", data.entity_type)
		Util.ItemType.SWORD:
			print("Sword does not do anything when right clicked!")
		Util.ItemType.PICKAXE:
			print("pickaxe does not do anything when right clicked!")
		Util.ItemType.SHOVEL:
			print("shovel does not do anything when right clicked!")


func calculate_block_break_time(voxel_id: int) -> float:
	var break_time = Util.items[voxel_id].hardness
	match data.type:
		Util.ItemType.PICKAXE:
			if is_pickaxe_block(voxel_id):
				return break_time / data.efficiency
			continue
		Util.ItemType.AXE:
			if is_axe_block(voxel_id):
				return break_time / data.efficiency
			continue
		Util.ItemType.SHOVEL:
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

