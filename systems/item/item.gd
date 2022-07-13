extends Node
class_name Item
@icon("res://assets/beef.png")

@export var data: Resource = preload("res://data/blocks/dirt_item.tres")

enum Types {BLOCK, CONSUMABLE}

func primary_action() -> void:
	pass

func secondary_action() -> void:
	if data.type == Types.BLOCK:
		Signals.emit_signal("place_block", data.voxel_id)
	else:
		print("Block was not placed; this is a consumable item")
