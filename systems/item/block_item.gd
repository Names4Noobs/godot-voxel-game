extends Item
class_name BlockItem
@icon("res://assets/dirt.png") 

@export var voxel_id = 1



func _init(p_id: int=voxel_id) -> void:
	voxel_id = p_id

func primary_action() -> void:
	print("Overriden action")


func secondary_action() -> void:
	print("Place block")
	$%VoxelInteraction.place_block(voxel_id)
