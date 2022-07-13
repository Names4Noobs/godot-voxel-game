extends Node

# Inventory related signals
signal changed_selected_slot(new_slot: int)
signal inventory_swap_slots(slot_id1: int, slot_id2: int)
signal amount_changed
signal inventory_changed(slot_data: Array)

# Request to server
signal place_block(vox_id: int)
signal destroy_block
signal hit_pointed_entity
