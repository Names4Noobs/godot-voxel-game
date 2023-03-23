extends VBoxContainer

var slot_id: int
var hotbar: Hotbar
var inventory: Inventory
@onready var amount_label := $PanelContainer/Control/Label
@onready var item_texture_rect := $PanelContainer/Control/MarginContainer/TextureRect
@onready var color_rect := $ColorRect 



func _ready() -> void:
	Events.connect("player_spawned", _on_player_spawned)
	slot_id = get_index()


func _on_player_spawned(spawned_player: Player) -> void:
	inventory = spawned_player.get_inventory()
	hotbar = spawned_player.get_hotbar()
	if hotbar != null:
		hotbar.connect("selected_slot_changed", _on_selected_slot_changed)
		_on_selected_slot_changed(hotbar.selected_slot)
	if inventory != null:
		var slot := inventory.slots[slot_id]
		slot.connect("item_changed", _on_item_changed)
		slot.connect("amount_changed", _on_amount_changed)
		_on_item_changed(slot.item)
		_on_amount_changed(slot.amount)


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
	if new_amount <= 1:
		amount_label.hide()
		return
	if not amount_label.visible:
		amount_label.show()
