extends Node


# Serverbound
signal inventory_swap_slots(slot_id1: int, slot_id2: int)
signal place_block(vox_id: int)
signal destroy_block
signal hit_pointed_entity
signal drop_item(item_data: Resource)
signal eat_food(food_data: Resource)
signal place_block_entity

#NOTE: These signals are probably temporary
signal hide_hud
signal show_hud

# Clientbound
signal player_died
signal changed_selected_slot(slot_data: Resource)
signal item_amount_changed
signal inventory_changed(slot_data: Array, slot_number: int)
