extends Control

signal opened(opened: bool)

@onready var player_inventory := $PlayerInventory
@onready var container_inventory := $ContainerInventory

func _ready() -> void:
	Game.player_menu = self
	_set_player_inventory()
	container_inventory.hide()
	hide()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("toggle_inventory"):
		close() if visible else open() 


func close() -> void:
	hide()
	Game.player.is_input_disabled = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if container_inventory.visible:
		container_inventory.hide()
	emit_signal("opened", false)


func open() -> void:
	show()
	Game.player.is_input_disabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	emit_signal("opened", true)


func open_container(inventory_id: int) -> void:
	var inventory = Game.get_inventory(inventory_id)
	if inventory == null:
		return
	_set_container_inventory(inventory)
	open()
	container_inventory.show()


func _set_container_inventory(slots: Array[ItemStack]) -> void:
	var slot_num := len(slots) - 1
	for child in container_inventory.get_children():
		if child is HBoxContainer:
			for slot in child.get_children():
				slot.set_slot(8-slot_num, slots[8-slot_num])
				slot_num -= 1


func _set_player_inventory() -> void:
	var inv := Game.player_inventory
	var slot_num := len(inv.slots) - 1
	for child in player_inventory.get_children():
		if child is HBoxContainer:
			for slot in child.get_children():
				slot.set_slot(8-slot_num, inv.slots[8-slot_num])
				slot_num -= 1
