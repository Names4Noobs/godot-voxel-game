extends Node

signal changed_selected_slot(new_slot: int)

signal place_block(vox_id: int)
signal destroy_block()

signal hit_pointed_entity()

# This should be deprecated
signal selected_new_voxel(new_id: int)
signal placed_voxel(pos: Vector3i, v_name)
signal broke_voxel(pos: Vector3i, v_name)
