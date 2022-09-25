extends Control

var test_icon := preload("res://icon.png")

@onready var world_list: ItemList = $VBoxContainer/ItemList
@onready var create_world_button := $VBoxContainer/HBoxContainer/VBoxContainer2/CreateNewWorld
@onready var edit_world_button := $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/EditWorld
@onready var play_world_button := $VBoxContainer/HBoxContainer/VBoxContainer/PlaySelectedWorld
@onready var delete_world_button := $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/DeleteWorld
@onready var cancel_button := $VBoxContainer/HBoxContainer/VBoxContainer2/Cancel

# Create world nodes
@onready var create_world_menu := $CreateWorldMenu
@onready var generator_options: OptionButton = create_world_menu.get_node("VBoxContainer/VBoxContainer/GeneratorOptions")
@onready var gamemode_options: OptionButton = create_world_menu.get_node("VBoxContainer/VBoxContainer4/GamemodeOptions")


func _ready() -> void:
	_get_worlds_from_folder()
	world_list.connect("item_activated", _on_world_activated)
	create_world_button.connect("pressed", _on_create_world_pressed)
	cancel_button.connect("pressed", _on_cancel_pressed)
	world_list.grab_focus()
	_add_world_generator_options()
	_add_gamemode_options()
	for i in range(10):
		world_list.add_item("World %d" % i, test_icon)


func _get_worlds_from_folder() -> void:
	var dir := Directory.new()
	if !dir.dir_exists("user://saves/"):
		dir.make_dir("user://saves/")
	# TODO: This should return world save files once those are a thing

func _add_world_generator_options() -> void:
	generator_options.add_icon_item(test_icon, "Normal")
	generator_options.add_icon_item(test_icon, "Flatlands")
	generator_options.add_icon_item(test_icon, "Islands")


func _add_gamemode_options() -> void:
	gamemode_options.add_icon_item(test_icon, "Survival")
	gamemode_options.add_icon_item(test_icon, "Creative")


func _on_create_world_pressed() -> void:
	$CreateWorldMenu.show()


func _on_delete_world_pressed() -> void:
	pass


func _on_edit_world_pressed() -> void:
	pass


func _on_play_world_pressed() -> void:
	pass


func _on_cancel_pressed() -> void:
	queue_free()


func _on_world_activated(index: int) -> void:
	pass
