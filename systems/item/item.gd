extends Node
class_name Item
@icon("res://assets/textures/item/beef.png")


enum Type {BLOCK, CONSUMABLE, BLOCK_ENTITY}

@export var data: Resource = Util._dirt_item


func primary_action() -> void:
	pass


func secondary_action() -> void:
	match data.type:
		Type.BLOCK:
			Signals.emit_signal("place_block", data.voxel_id)
		Type.CONSUMABLE:
			get_parent().remove_amount(1)
			Signals.emit_signal("eat_food", data)
		Type.BLOCK_ENTITY:
			Signals.emit_signal("place_block", data.voxel_id)
			Signals.emit_signal("place_block_entity")
