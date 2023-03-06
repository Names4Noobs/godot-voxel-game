extends Node3D

var inventory: Inventory
@onready var block_animation_player := $CSGBox3D/AnimationPlayer
@onready var hand_animation_player := $hand/AnimationPlayer

func _ready() -> void:
	Game.connect("block_placed", _on_block_placed)
	inventory = Game.player_inventory
	inventory.connect("selected_slot_changed", _on_selected_slot_changed)
	var slot := inventory.get_selected_slot()
	if not slot.is_empty():
		$CSGBox3D.material_override.albedo_texture = slot.item.texture

func _on_selected_slot_changed(_new_slot_id: int) -> void:
	var slot := inventory.get_selected_slot()
	if not slot.is_empty():
		$CSGBox3D.material_override.albedo_texture = slot.item.texture


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("primary_action"):
		hand_animation_player.play("swing")


func _on_block_placed() -> void:
	block_animation_player.play("place")
	
