extends Control


var dirt_icon := preload("res://assets/textures/block/dirt.png")
var grass_icon := preload("res://assets/textures/block/grass_block_side.png")
var furnace_icon := preload("res://assets/textures/block/furnace_front.png")
var crafting_table_icon := preload("res://assets/textures/block/crafting_table_front.png")

var test_world := preload("res://systems/world/world.tscn")
var create_world_menu := preload("res://ui/SingleplayerMenu/CreateWorldMenu/CreateWorldMenu.tscn")

@onready var world_list: ItemList = $VBoxContainer/ItemList
@onready var create_world_button := $VBoxContainer/HBoxContainer/VBoxContainer2/CreateNewWorld
@onready var edit_world_button := $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/EditWorld
@onready var play_world_button := $VBoxContainer/HBoxContainer/VBoxContainer/PlaySelectedWorld
@onready var delete_world_button := $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/DeleteWorld
@onready var cancel_button := $VBoxContainer/HBoxContainer/VBoxContainer2/Cancel




func _ready() -> void:
	_get_worlds_from_folder()
	world_list.connect(&"item_activated", _on_world_activated)
	create_world_button.connect(&"pressed", _on_create_world_pressed)
	delete_world_button.connect(&"pressed", _on_delete_world_pressed)
	cancel_button.connect(&"pressed", _on_cancel_pressed)
	world_list.grab_focus()

	for i in range(10):
		match i % 4:
			0:
				world_list.add_item("World %d" % i, dirt_icon)
			1:
				world_list.add_item("World %d" % i, crafting_table_icon)
			2:
				world_list.add_item("World %d" % i, furnace_icon)
			_:
				world_list.add_item("World %d" % i, grass_icon)


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_ESCAPE:
				get_viewport().set_input_as_handled()
				queue_free()


func _get_worlds_from_folder() -> void:
	var dir := Directory.new()
	if !dir.dir_exists("user://saves/"):
		dir.make_dir("user://saves/")
	# TODO: This should return world save files once those are a thing




func _on_create_world_pressed() -> void:
	add_child(create_world_menu.instantiate())


func _on_delete_world_pressed() -> void:
	var popup: ConfirmationDialog = $DeleteWorldConfirmationDialog
	# Is there a better way to change the font size?
	var label_settings := LabelSettings.new()
	label_settings.font_size = 32
	popup.get_label().label_settings = label_settings
	popup.popup_centered()


func _on_edit_world_pressed() -> void:
	pass


func _on_play_world_pressed() -> void:
	pass


func _on_cancel_pressed() -> void:
	queue_free()


func _on_world_activated(_index: int) -> void:
	queue_free()
	get_tree().change_scene_to_packed(test_world)

