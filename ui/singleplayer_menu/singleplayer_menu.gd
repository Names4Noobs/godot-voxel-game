extends Control


var dirt_icon := preload("res://assets/textures/block/dirt.png")
var grass_icon := preload("res://assets/textures/block/grass_block_side.png")
var furnace_icon := preload("res://assets/textures/block/furnace_front.png")
var crafting_table_icon := preload("res://assets/textures/block/crafting_table_front.png")

var test_world := load("res://systems/world/world.tscn")
var create_world_menu := preload("res://ui/singleplayer_menu/create_world_menu/create_world_menu.tscn")

@onready var world_list: ItemList = $VBoxContainer/ItemList
@onready var create_world_button := $VBoxContainer/HBoxContainer/VBoxContainer2/CreateNewWorld
@onready var edit_world_button := $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/EditWorld
@onready var play_world_button := $VBoxContainer/HBoxContainer/VBoxContainer/PlaySelectedWorld
@onready var delete_world_button := $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/DeleteWorld
@onready var cancel_button := $VBoxContainer/HBoxContainer/VBoxContainer2/Cancel

var world_saves: Array[Resource] = []


func _ready() -> void:
	world_list.connect(&"item_activated", _on_world_activated)
	create_world_button.connect(&"pressed", _on_create_world_pressed)
	delete_world_button.connect(&"pressed", _on_delete_world_pressed)
	cancel_button.connect(&"pressed", _on_cancel_pressed)
	world_list.grab_focus()

# TODO: Redesign world saves when they are necessary.

#	var world := WorldSave.new()
#	world.world_name = "Flat World"
#	world.world_scene_path = "misc/main/main.tscn"
#	world.save_world()
#
#	var world2 := WorldSave.new()
#	world2.world_name = "Mountains World"
#	world2.save_world()
#
#	_get_worlds_from_disk()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_ESCAPE:
				get_viewport().set_input_as_handled()
				queue_free()


func _create_saves_folder() -> void:
	DirAccess.make_dir_absolute("user://saves/")
#	var dir := DirAccess.new()
#	if !dir.dir_exists("user://saves/"):
#		dir.make_dir("user://saves/")
#	DirAccess.make_dir_absolute("user://saves/")



func _get_worlds_from_disk() -> void:
	_create_saves_folder()
	var dir := DirAccess.open("user://saves/")
	if dir != null:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				if ResourceLoader.exists(WorldSave.SAVE_PATH + file_name):
					var res = load(WorldSave.SAVE_PATH + file_name) 
					world_saves.append(res)
					if res is WorldSave:
						world_list.add_item(res.world_name, load(res.world_icon))
				file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")




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


func _on_world_activated(index: int) -> void:
	var save = world_saves[index]
	print(index)
	queue_free()
	get_tree().change_scene_to_packed(load(save.world_scene_path))

