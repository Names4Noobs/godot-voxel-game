extends Control

var slot_id: int
var inventory: Inventory


func _drop_data(_at_position: Vector2, data) -> void:
	if typeof(data) == TYPE_DICTIONARY: 
		if data.has("slot_id") and data.has("inventory"):
			var other_slot_id = data["slot_id"]
			var other_inventory = data["inventory"]
			var item_slot = inventory.slots[slot_id]
			if item_slot == null:
				return
			if item_slot.item == null:
				var inv = inventory
				var temp = inv.slots[slot_id].duplicate()
				inv.slots[slot_id].copy(other_inventory.slots[other_slot_id]) 
				other_inventory.slots[other_slot_id].copy(temp)


func _get_drag_data(_at_position: Vector2) -> Variant:
	var item_slot = inventory.slots[slot_id]
	if item_slot == null:
		return
	var preview := TextureRect.new()
	preview.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
	if not item_slot.is_empty():
		if item_slot.item.texture != null:
			preview.texture = item_slot.item.texture
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.size = Vector2i(64, 64)
	set_drag_preview(preview)
	return { "slot_id":  slot_id, "inventory": inventory}


func _can_drop_data(_at_position: Vector2, data) -> bool:
	if typeof(data) == TYPE_DICTIONARY: 
		if data.has("slot_id"):
			return true
	return false


func _input(_event: InputEvent) -> void:
	if not is_visible_in_tree():
		return
	if get_rect().has_point(get_local_mouse_position()):
		$ColorRect.show()
	else:
		$ColorRect.hide()
