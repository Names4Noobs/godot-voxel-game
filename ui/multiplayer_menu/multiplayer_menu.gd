extends Control


var direct_connect_menu := preload("res://ui/multiplayer_menu/direct_connect_menu/direct_connect_menu.tscn")

@onready var server_list: ItemList = $VBoxContainer/ServerItemList

@onready var join_button := $VBoxContainer/VBoxContainer/HBoxContainer/JoinServer
@onready var direct_connection_button := $VBoxContainer/VBoxContainer/HBoxContainer/DirectConnection
@onready var add_server_button := $VBoxContainer/VBoxContainer/HBoxContainer/AddServer
@onready var edit_button := $VBoxContainer/VBoxContainer/HBoxContainer2/Edit
@onready var delete_button := $VBoxContainer/VBoxContainer/HBoxContainer2/Delete
@onready var refresh_button := $VBoxContainer/VBoxContainer/HBoxContainer2/Refresh
@onready var cancel_button := $VBoxContainer/VBoxContainer/HBoxContainer2/Cancel


func _ready() -> void:
	server_list.connect(&"item_activated", _on_item_activated)
	join_button.connect(&"pressed", _on_join_button_pressed)
	direct_connection_button.connect(&"pressed", _on_direct_connection_button_pressed)
	add_server_button.connect(&"pressed", _on_add_server_button_pressed)
	edit_button.connect(&"pressed", _on_edit_button_pressed)
	delete_button.connect(&"pressed", _on_delete_button_pressed)
	refresh_button.connect(&"pressed", _on_refresh_button_pressed)
	cancel_button.connect(&"pressed", _on_back_button_pressed)
	
	join_button.grab_focus()
	server_list.select(0)


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_ESCAPE:
				get_viewport().set_input_as_handled()
				queue_free()


func _on_item_activated(index: int) -> void:
	if index == 0:
		print("Connect to localhost")

func _on_add_server_button_pressed() -> void:
	print("Open add server menu")


func _on_edit_button_pressed() -> void:
	print("Open edit server menu")


func _on_refresh_button_pressed() -> void:
	print("Ping all servers in list")


func _on_delete_button_pressed() -> void:
	print("Open popup asking if the user really wants to delete the server")


func _on_direct_connection_button_pressed() -> void:
	add_child(direct_connect_menu.instantiate())


func _on_join_button_pressed() -> void:
	if server_list.is_anything_selected():
		print("Try to connect to ip")


func _on_back_button_pressed() -> void:
	queue_free()
