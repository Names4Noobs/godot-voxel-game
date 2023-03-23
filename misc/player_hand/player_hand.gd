extends Node3D


var player: Player
var hotbar: Hotbar
@onready var block_animation_player := $BlockRenderer/AnimationPlayer
@onready var hand_animation_player := $hand/AnimationPlayer
@onready var hand := $hand
@onready var block_renderer := $BlockRenderer
@onready var sprite := $Sprite3D


func _ready() -> void:
	Events.connect("block_placed", _on_block_placed)
	Events.connect("player_spawned", _on_player_spawned)



func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("primary_action"):
		hand_animation_player.stop()
		hand_animation_player.play("swing")
		block_animation_player.stop()
		block_animation_player.play("swing")


func _update_player_hand(slot: ItemStack) -> void:
	block_renderer.hide()
	hand.hide()
	sprite.hide()
	if not slot.is_empty():
		if slot.item is BlockItem:
			hand.hide()
			block_renderer.set_block_textures(Game.get_block(slot.item.block_id))
			block_renderer.show()
			return
		if slot.item is Item:
			sprite.texture = slot.item.texture
			sprite.show()
	else:
		hand.show()

func _on_player_spawned(spawned_player: Player) -> void:
	player = spawned_player
	hotbar = player.get_hotbar()
	hotbar.connect("selected_slot_changed", _on_selected_slot_changed)


func _on_selected_slot_changed(_new_slot_id: int) -> void:
	var slot := hotbar.get_selected_slot()
	if not slot.is_connected("item_changed", _on_item_changed):
		slot.connect("item_changed", _on_item_changed)
	_update_player_hand(slot)


func _on_block_placed() -> void:
	block_animation_player.stop()
	block_animation_player.play("place")


func _on_item_changed(_item: Item) -> void:
	var slot := hotbar.get_selected_slot()
	_update_player_hand(slot)


