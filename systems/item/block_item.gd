extends Item
class_name BlockItem
@icon("res://assets/dirt.png") 

@export var data: Resource = ItemData.new()


func primary_action() -> void:
	print("Overriden action")


func secondary_action() -> void:
	print("Place block")
	Signals.emit_signal("place_block", data.voxel_id)
