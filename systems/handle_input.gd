extends Node

var pause_screen := preload("res://ui/pause_menu/pause_menu.tscn")
var inventory_screen := preload("res://ui/player_menu/player_menu.tscn")


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_ESCAPE:
				get_parent().add_child(pause_screen.instantiate())
				get_viewport().set_input_as_handled()
	if Input.is_action_just_pressed("open_inventory"):
			get_parent().add_child(inventory_screen.instantiate())
			get_viewport().set_input_as_handled()
