extends Control

var player: Player

@onready var player_inventory := $PlayerInventory
@onready var container_inventory := $ContainerInventory

func _ready() -> void:
	Events.connect("player_spawned", _on_player_spawned)
	Events.connect("container_opened", _on_container_opened)
	container_inventory.hide()
	hide()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("toggle_inventory"):
		close() if visible else open() 


func _gui_input(_event: InputEvent) -> void:
	# TODO: Actually make this work....
	var target := Vector3(-get_global_mouse_position().x/200, 1.5 + -(get_global_mouse_position().y/135), -20)
	$SubViewportContainer/SubViewport/PlayerPreview/player/Node2/Head2.look_at(target)


func close() -> void:
	if not player:
		return
	hide()
	# TODO: Make player listen for input when player_menu_closed is emitted
	#Game.player.is_input_disabled = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if container_inventory.visible:
		container_inventory.hide()
	Events.emit_signal("player_menu_closed")


func open() -> void:
	if not player:
		return
	show()
	# TODO: Make player stop listening for input when player_menu_opened is emitted
	#Game.player.is_input_disabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Events.emit_signal("player_menu_opened")


func open_container(inventory: Inventory) -> void:
	_update_container_inventory(inventory)
	open()
	container_inventory.show()


func _update_container_inventory(inventory: Inventory) -> void:
	var slot_num := 0
	for child in container_inventory.get_children():
		if child is HBoxContainer:
			for slot in child.get_children():
				slot.set_slot(slot_num, inventory)
				slot_num += 1


func _update_player_inventory() -> void:
	var inv := player.get_inventory()
	var slot_num := len(inv.slots) - 1
	for child in player_inventory.get_children():
		if child is HBoxContainer:
			for slot in child.get_children():
				slot.set_slot(8-slot_num, inv)
				slot_num -= 1


func _on_player_spawned(spawned_player: Player) -> void:
	player = spawned_player
	_update_player_inventory()


func _on_container_opened(inventory: Inventory) -> void:
	open_container(inventory)
