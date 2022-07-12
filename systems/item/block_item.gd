extends Item
class_name BlockItem
@icon("res://assets/dirt.png") 

@export var data: Resource = BlockItemData.new()


#
#func _init(p_data: BlockItemData) -> void:
#	data = p_data 

func primary_action() -> void:
	print("Overriden action")


func secondary_action() -> void:
	print("Place block")
	Signals.emit_signal("place_block", data.voxel_id)
