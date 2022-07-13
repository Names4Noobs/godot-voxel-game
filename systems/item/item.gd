extends Node
class_name Item
@icon("res://assets/beef.png")


enum Types {BLOCK, CONSUMABLE}

@export var data: Resource = preload("res://data/blocks/dirt_item.tres")


func primary_action() -> void:
	pass

func secondary_action() -> void:
	if data.type == Types.BLOCK:
		Signals.emit_signal("place_block", data.voxel_id)
	else:
		print("Block was not placed; this is a consumable item")
