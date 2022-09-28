# Inventory Manager: this handles the inputs and modifies 
# the player's inventory resource
extends Node

var inventory: Resource

func _ready() -> void:
	inventory = Util.get_player_inventory()


func _physics_process(_delta: float) -> void:
	if inventory == null:
		return
	
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
		inventory.drop_stack()
	elif Input.is_action_just_pressed("drop_item"):
		inventory.drop_item(1)
