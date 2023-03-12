extends Node3D



var inventory: Inventory
@onready var block_animation_player := $BlockRenderer/AnimationPlayer
@onready var hand_animation_player := $hand/AnimationPlayer
@onready var hand := $hand
@onready var block_renderer := $BlockRenderer


func _ready() -> void:
	Game.connect("block_placed", _on_block_placed)
	inventory = Game.player_inventory
	inventory.connect("selected_slot_changed", _on_selected_slot_changed)
	_on_selected_slot_changed(420)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("primary_action"):
		hand_animation_player.stop()
		hand_animation_player.play("swing")
		block_animation_player.stop()
		block_animation_player.play("swing")


func _update_player_hand(slot: ItemStack) -> void:
	if not slot.is_empty():
		if slot.item is BlockItem:
			hand.hide()
			block_renderer.set_block_textures(Game.get_block(slot.item.block_id))
			block_renderer.show()
			return
	block_renderer.hide()
	hand.show()


func _on_selected_slot_changed(_new_slot_id: int) -> void:
	var slot := inventory.get_selected_slot()
	if not slot.is_connected("item_changed", _on_item_changed):
		slot.connect("item_changed", _on_item_changed)
	_update_player_hand(slot)


func _on_block_placed() -> void:
	block_animation_player.stop()
	block_animation_player.play("place")


func _on_item_changed(_item: Item) -> void:
	var slot := inventory.get_selected_slot()
	_update_player_hand(slot)


