extends VBoxContainer

var slot_id: int
var inventory: Inventory
@onready var amount_label := $PanelContainer/Control/Label
@onready var item_texture_rect := $PanelContainer/Control/MarginContainer/TextureRect
@onready var color_rect := $ColorRect 



func _ready() -> void:
	slot_id = get_index()
	inventory = Game.player_inventory
	if inventory != null:
		inventory.connect("selected_slot_changed", _on_selected_slot_changed)
		var slot := inventory.slots[slot_id]
		slot.connect("item_changed", _on_item_changed)
		slot.connect("amount_changed", _on_amount_changed)
		if slot.item != null:
			item_texture_rect.texture = slot.item.texture
		amount_label.text = str(slot.amount)
		if slot.amount == 0:
			amount_label.hide()
		if inventory.selected_slot != slot_id:
			color_rect.hide()
		else:
			color_rect.show()


func _on_selected_slot_changed(new_slot_id: int) -> void:
	if new_slot_id != slot_id:
		color_rect.hide()
	else:
		color_rect.show()


func _on_item_changed(new_item: Item) -> void:
	if new_item == null:
		item_texture_rect.texture = null
	else:
		if not amount_label.visible:
			amount_label.show()
		item_texture_rect.texture = new_item.texture


func _on_amount_changed(new_amount: int) -> void:
	if new_amount == null:
		return
	amount_label.text = str(new_amount)
	if new_amount == 0:
		amount_label.hide()
		return
	if not amount_label.visible:
		amount_label.show()
