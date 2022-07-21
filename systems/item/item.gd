extends Node
class_name Item
@icon("res://assets/textures/item/beef.png")


@export var data: Resource = Util._dirt_item


func primary_action() -> void:
	match data.type:
		Util.ItemType.SWORD:
			print("This should do a lot of damage!")
			Signals.emit_signal("player_damage_pointed_entity", 10)


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
