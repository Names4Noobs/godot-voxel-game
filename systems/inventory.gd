# Inventory Manager: this handles the inputs and modifies 
# the player's inventory resource
extends Node


@export var inventory: Resource

@onready var item = $Item

func _ready() -> void:
	Signals.connect("changed_selected_slot", Callable(self, "_swap_data"))
	inventory = Inventory.new()


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released("scroll_up"):
		inventory.selected_slot += 1
	elif Input.is_action_just_released("scroll_down"):
		inventory.selected_slot -= 1
	elif Input.is_action_just_pressed("select_slot1"):
		inventory.selected_slot = 0
	elif Input.is_action_just_pressed("select_slot2"):
		inventory.selected_slot = 1
	elif Input.is_action_just_pressed("select_slot3"):
		inventory.selected_slot = 2
	elif Input.is_action_just_pressed("select_slot4"):
		inventory.selected_slot = 3
	elif Input.is_action_just_pressed("select_slot5"):
		inventory.selected_slot = 4
	elif Input.is_action_just_pressed("select_slot6"):
		inventory.selected_slot = 5
	elif Input.is_action_just_pressed("select_slot7"):
		inventory.selected_slot = 6
	elif Input.is_action_just_pressed("select_slot8"):
		inventory.selected_slot = 7
	elif Input.is_action_just_pressed("select_slot9"):
		inventory.selected_slot = 8
	elif Input.is_action_just_pressed("drop_stack"):
		var slot = inventory.get_selected_slot()
		if slot != null:
			# TODO: Only drop the items when you have enough to drop!
			if !slot.is_empty:
				Signals.emit_signal("drop_item", slot.item, Vector3.ZERO, 16, false)
				remove_amount(16)
	elif Input.is_action_just_pressed("drop_item"):
		var slot = inventory.get_selected_slot()
		if slot != null:
			if !slot.is_empty:
				Signals.emit_signal("drop_item", slot.item, Vector3.ZERO, 1, false)
				remove_amount(1)

func _swap_data(slot_data: Resource, _slot_number: int) -> void:
	if item != null and !slot_data.is_empty:
		item.data = slot_data.item


# NOTE: Temporary
func remove_amount(amount: int) -> void:
	if inventory.slots[inventory.selected_slot] != null:
		inventory.slots[inventory.selected_slot].quantity -= amount
		Signals.emit_signal("inventory_slot_changed", inventory.slots[inventory.selected_slot])


func is_selected_slot_empty() -> bool:
	if inventory.slots[inventory.selected_slot].is_empty:
		return true
	else:
		return false
