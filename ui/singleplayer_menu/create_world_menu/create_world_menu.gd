extends Control

var test_icon := preload("res://icon.png")

@onready var generator_options := $VBoxContainer/Generator/GeneratorOptions
@onready var gamemode_options := $VBoxContainer/Gamemode/GamemodeOptions
@onready var generate_button := $HBoxContainer/CreateNewWorld
@onready var cancel_button := $HBoxContainer/Cancel

func _ready() -> void:
	generate_button.connect(&"pressed", _on_generate_button_pressed)
	cancel_button.connect(&"pressed", _on_cancel_button_pressed)
	_add_world_generator_options()
	_add_gamemode_options()


func _add_world_generator_options() -> void:
	generator_options.add_icon_item(test_icon, "Normal")
	generator_options.add_icon_item(test_icon, "Flatlands")
	generator_options.add_icon_item(test_icon, "Islands")


func _add_gamemode_options() -> void:
	gamemode_options.add_icon_item(test_icon, "Survival")
	gamemode_options.add_icon_item(test_icon, "Creative")


func _on_generate_button_pressed() -> void:
	print("Generate world and stuff like that")


func _on_cancel_button_pressed() -> void:
	queue_free()
