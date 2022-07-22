extends Node


# Serverbound
signal inventory_swap_slots(slot_id1: int, slot_id2: int)
signal place_block(vox_id: int)
signal create_explosion(position: Vector3i, radius: int)
signal destroy_block
signal hit_pointed_entity
signal drop_item(item_data: ItemData, location: Vector3, amount: int, use_location: bool)
signal eat_food(food_data: Resource)
signal place_block_entity(type: int)

#NOTE: These signals are probably temporary
signal hide_hud
signal show_hud

# Clientbound
signal player_died
signal player_respawned
signal player_moved
signal changed_selected_slot(slot_data: Resource)
signal item_amount_changed
signal inventory_changed(slot_data: Array, slot_number: int)


# The player is currently not on floor
signal player_falling
# The player is currently on floor
signal player_fell
signal player_damage(amount: int, type: int)

# Player stats signals
signal player_health_changed(value: int)
signal player_stamina_changed(value: int)

signal player_health_requested
signal player_stamina_requested

signal player_damage_pointed_entity(amount: int)
