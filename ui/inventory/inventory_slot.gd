extends VBoxContainer


var item_slot: ItemStack

@onready var amount_label := $PanelContainer/Control/Label
@onready var item_texture_rect := $PanelContainer/Control/MarginContainer/TextureRect

func _ready() -> void:
	pass 


func set_slot(slot: ItemStack) -> void:
	slot.connect("item_changed", _update_item)
	slot.connect("amount_changed", _update_amount)
	_update_item(slot.item)
	_update_amount(slot.amount)
	item_slot = slot


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
