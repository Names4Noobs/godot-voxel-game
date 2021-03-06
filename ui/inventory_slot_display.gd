extends Control

@export var slot_number = -1


func _get_drag_data(_at_position: Vector2):
	var data = {}
	data["swapped_slot"] = slot_number
	
	# Create texture
	var node := TextureRect.new()
	node.texture = $TextureRect.texture
	node.size = Vector2(32,32)
	
	# Create control to change texture pos from
	var control := Control.new()
	control.add_child(node)
	node.position = -0.5 * node.size
	set_drag_preview(control)
	
	return data


func _can_drop_data(_at_position: Vector2, data) -> bool:
	if data.has("swapped_slot"):
		return true
	else:
		printerr(str(self) + "Failed to drop data on this control!")
		return false


func _drop_data(_at_position: Vector2, data) -> void:
	Signals.emit_signal("inventory_swap_slots", slot_number, data["swapped_slot"])
