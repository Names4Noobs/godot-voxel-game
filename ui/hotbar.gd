extends HBoxContainer

var inv_slot = load("res://ui/inventory_slot_display.tscn")
var inventory: Node
var icon_size := Vector2(64,64)
const HOTBAR_SIZE = 9

var slot_data: Array
var selected_slot: int:
	set(v):
		_update_selector(v)
		selected_slot = v


func _ready() -> void:
	_build_ui()
	get_child(0).get_node("ColorRect").show()
	Signals.connect("inventory_changed", Callable(self, "_update_ui"))
	Signals.connect("changed_selected_slot", Callable(self, "_on_selected_slot"))
	Signals.connect("inventory_slot_changed", Callable(self, "_update_amount"))
	inventory = Util.get_inventory()


func _build_ui() -> void:
	var number = 0
	for i in HOTBAR_SIZE:
		var slot = inv_slot.instantiate()
		slot.slot_number = number
		add_child(slot)
		number += 1



# NOTE: This function gets all of the inventory data, 
# even the data which is not part of the hotbar
func _update_ui(data: Array) -> void:
	var idx = 0
	for i in data:
		# NOTE: This is to skip all data after index 8
		if idx >= 9:
			break
		if get_child(idx) != null:
			if !i.is_empty:
				get_child(idx).hint_tooltip = i.item.display_name
				get_child(idx).get_node("TextureRect").texture = i.item.texture
				get_child(idx).get_node("Label").show()
				get_child(idx).get_node("Label").text = str(i.quantity)
			else:
				get_child(idx).hint_tooltip = "Empty slot!"
				get_child(idx).get_node("TextureRect").texture = null
				get_child(idx).get_node("Label").hide()
			idx += 1

	slot_data = data


func _update_amount(slot: Resource) -> void:
	if slot.id >= 9:
		return
	slot_data[slot.id] = slot 
	if slot != null:
		if slot.is_empty:
				get_child(slot.id).hint_tooltip = "Empty slot!"
				get_child(slot.id).get_node("TextureRect").texture = null
				get_child(slot.id).get_node("Label").hide()
		else:
			if slot != null:
				get_child(slot.id).get_node("TextureRect").texture = slot.item.texture
			get_child(slot.id).get_node("Label").show()
			get_child(slot.id).get_node("Label").text = str(slot.quantity)
	

func _on_selected_slot(_slot_data: Resource, new_slot: int) -> void:
	selected_slot = new_slot


func _update_selector(new_slot: int) -> void:
	if new_slot == selected_slot:
		return
	get_child(new_slot).get_node("ColorRect").show()
	get_child(selected_slot).get_node("ColorRect").hide()

