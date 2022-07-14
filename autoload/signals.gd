extends Node


# Serverbound
signal inventory_swap_slots(slot_id1: int, slot_id2: int)
signal place_block(vox_id: int)
signal destroy_block
signal hit_pointed_entity
signal drop_item(item_data: Resource)

# Clientbound
signal changed_selected_slot(new_slot: int)
signal item_amount_changed
signal inventory_changed(slot_data: Array)
