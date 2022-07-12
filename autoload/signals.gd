extends Node

signal changed_selected_slot(new_slot: int)
signal inventory_swap_slots(slot_id1: int, slot_id2: int)

# Emitted when slot data has changed
signal inventory_changed(slot_data: Array)


signal place_block(vox_id: int)
signal destroy_block()

signal hit_pointed_entity()





# This should be deprecated
signal selected_new_voxel(new_id: int)
signal placed_voxel(pos: Vector3i, v_name)
signal broke_voxel(pos: Vector3i, v_name)
