extends VBoxContainer

var player: Player

@onready var amount_label := $PanelContainer/Control/Label
@onready var item_texture_rect := $PanelContainer/Control/MarginContainer/TextureRect
@onready var drag_control := $PanelContainer/Control


func set_slot(slot_num: int, inventory: Inventory) -> void:
	# TODO: Maybe cache inventory menus???
	# NOTE: This assumes that there are 9 slots per row
	var slot := inventory.slots[slot_num]
	if not slot.is_connected("item_changed", _update_item):
		slot.connect("item_changed", _update_item)
	if not slot.is_connected("amount_changed", _update_amount):
		slot.connect("amount_changed", _update_amount)
	_update_item(slot.item)
	_update_amount(slot.amount)
	drag_control.inventory = inventory
	drag_control.slot_id = slot_num


func _update_item(new_item: Item) -> void:
	if new_item == null:
		item_texture_rect.texture = null
	else:
		if not amount_label.visible:
			amount_label.show()
		item_texture_rect.texture = new_item.texture
		drag_control.tooltip_text = new_item.name


func _update_amount(new_amount: int) -> void:
	if new_amount == null:
		return
	amount_label.text = str(new_amount)
	if new_amount <= 1:
		amount_label.hide()
		return
	if not amount_label.visible:
		amount_label.show()
