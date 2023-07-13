extends Control

var drag_preview_scene := preload("res://ui/inventory/drag_preview.tscn")

var player: Player
var slot_id: int
var inventory: Inventory

@onready var highlight := $ColorRect


func _ready() -> void:
	Events.connect("player_spawned", func(v): player = v)


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
	if not item_slot.is_empty():
		if item_slot.item.texture != null:
			var drag_preview := drag_preview_scene.instantiate()
			drag_preview.get_node("VBoxContainer/TextureRect").texture = item_slot.item.texture
			drag_preview.get_node("VBoxContainer/Label").text = item_slot.item.name + " x" + str(item_slot.amount)
			set_drag_preview(drag_preview)
			return { "slot_id":  slot_id, "inventory": inventory}
	return

func _can_drop_data(_at_position: Vector2, data) -> bool:
	if typeof(data) == TYPE_DICTIONARY: 
		if data.has("slot_id"):
			return true
	return false


func _input(_event: InputEvent) -> void:
	if not is_visible_in_tree():
		return

	if get_rect().has_point(get_local_mouse_position()):
		highlight.show()
		if Input.is_action_just_released("drop_stack"):
			if player:
				player.item_dropper.drop_item(inventory.slots[slot_id], inventory.slots[slot_id].amount)
		elif Input.is_action_just_released("drop_item"):
			if player:
				player.item_dropper.drop_item(inventory.slots[slot_id], 1)

	else:
		highlight.hide()
