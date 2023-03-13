extends VBoxContainer



@onready var amount_label := $PanelContainer/Control/Label
@onready var item_texture_rect := $PanelContainer/Control/MarginContainer/TextureRect
@onready var drag_control := $PanelContainer/Control

func _ready() -> void:
	pass

func set_slot(slot_num: int, slot: ItemStack) -> void:
	slot.connect("item_changed", _update_item)
	slot.connect("amount_changed", _update_amount)
	_update_item(slot.item)
	_update_amount(slot.amount)
	drag_control.item_slot = slot
	drag_control.slot_id = slot_num


func _update_item(new_item: Item) -> void:
	if new_item == null:
		item_texture_rect.texture = null
	else:
		if not amount_label.visible:
			amount_label.show()
		item_texture_rect.texture = new_item.texture


func _update_amount(new_amount: int) -> void:
	if new_amount == null:
		return
	amount_label.text = str(new_amount)
	if new_amount <= 1:
		amount_label.hide()
		return
	if not amount_label.visible:
		amount_label.show()


		
