extends Control


var data: Array[Resource]
var inv_slot = preload("res://ui/slot_display/inventory_slot_display.tscn")
var player_inventory_data: Resource

@onready var grid_container: GridContainer = $GridContainer

func _ready() -> void:
	_build_ui()
	Signals.connect("inventory_changed", _update_ui)

	player_inventory_data = Util.get_player_inventory()
	Signals.emit_signal("inventory_changed", player_inventory_data.slots)
	_update_ui(player_inventory_data.slots)


func _build_ui() -> void:
	var number = 9
	for i in range(27):
		var slot = inv_slot.instantiate()
		slot.slot_number = number
		grid_container.add_child(slot)
		number += 1


func _update_ui(slot_data: Array) -> void:
	var idx = 0
	var count = 0
	for i in data:
		if count < 9:
			count += 1
			continue
		else:
			if grid_container.get_child(idx) != null:
				grid_container.get_child(idx).slot_data = i
				if !i.is_empty:
					grid_container.get_child(idx).tooltip_text = i.item.name
					grid_container.get_child(idx).get_node("TextureRect").texture = i.item.texture
					grid_container.get_child(idx).get_node("Label").show()
					grid_container.get_child(idx).get_node("Label").text = str(i.quantity)
				else:
					grid_container.get_child(idx).tooltip_text = "Empty slot!"
					grid_container.get_child(idx).get_node("TextureRect").texture = null
					grid_container.get_child(idx).get_node("Label").hide()
				idx += 1
	data = slot_data
