extends Node


signal hit_pointed_entity()

# Voxel
signal selected_new_voxel(new_id: int)
signal placed_voxel(pos: Vector3i, v_name)
signal broke_voxel(pos: Vector3i, v_name)
