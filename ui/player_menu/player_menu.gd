extends Control

@onready var player_inventory := $PlayerInventory

func _ready() -> void:
	Game.player_menu = self
	_set_inventory()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("toggle_inventory"):
		if visible:
			hide()
			Game.player.is_input_disabled = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			show()
			Game.player.is_input_disabled = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _set_inventory() -> void:
	var inv := Game.player_inventory
	var slot_num := len(inv.slots) - 1
	for child in player_inventory.get_children():
		if child is HBoxContainer:
			for slot in child.get_children():
				slot.set_slot(8-slot_num, inv.slots[8-slot_num])
				slot_num -= 1
