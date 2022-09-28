extends Node

signal selected_block_changed(pos: Vector3i, block_data: Resource)
signal inventory_swap_slots(slot_id1: int, slot_id2: int)

signal create_explosion(position: Vector3i, radius: int)
signal destroy_block
signal hit_pointed_entity

signal eat_food(food_data: Resource)
signal place_block_entity(type: int)

# Voxel interaction signals:
signal place_block(vox_id: int)
signal drop_item(item_data: ItemData, location: Vector3, amount: int, use_location: bool)

#NOTE: These signals are probably temporary
signal hide_hud
signal show_hud

signal fire_projectile(type: int, direction: Vector3)

signal player_died
signal player_respawned
signal player_moved

signal changed_selected_slot(slot_data: Resource)
signal inventory_slot_changed(slot_data: Resource)
signal inventory_changed(slot_data: Array, slot_id: int)

signal player_damage(amount: int, type: int)
signal player_heal(amount: int)

# Player stats signals
signal player_health_changed(value: int)
signal player_stamina_changed(value: int)

signal player_health_requested
signal player_stamina_requested

signal player_damage_pointed_entity(amount: int)

# Player state changed signals
signal player_sprint_state_changed(sprinting: bool)
# TODO: Make player_fall and fell one signal
# A state machine system would be helpful
signal player_falling
signal player_fell

# Chat signals
signal message_sent(msg: String)

# Inventory signals
signal add_item_to_inventory(item: Resource, item_count: int)
