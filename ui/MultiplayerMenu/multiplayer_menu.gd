extends Control

@onready var server_list: ItemList = $VBoxContainer/ServerItemList
@onready var join_button := $VBoxContainer/VBoxContainer/HBoxContainer/JoinServer
@onready var direct_connection_button := $VBoxContainer/VBoxContainer/HBoxContainer/DirectConnection
@onready var add_server_button := $VBoxContainer/VBoxContainer/HBoxContainer/AddServer

@onready var edit_button := $VBoxContainer/VBoxContainer/HBoxContainer2/Edit
@onready var delete_button := $VBoxContainer/VBoxContainer/HBoxContainer2/Delete
@onready var refresh_button := $VBoxContainer/VBoxContainer/HBoxContainer2/Refresh
@onready var cancel_button := $VBoxContainer/VBoxContainer/HBoxContainer2/Cancel


func _ready() -> void:
	cancel_button.connect("pressed", _on_back_button_pressed)
	join_button.grab_focus()
	server_list.select(0)


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_ESCAPE:
				get_viewport().set_input_as_handled()
				queue_free()


func _on_back_button_pressed() -> void:
	queue_free()
