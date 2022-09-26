extends Control


var singeplayer_menu := preload("res://ui/SingleplayerMenu/singleplayer_menu.tscn")
var options_menu := preload("res://ui/OptionsMenu/options_menu.tscn")
var multiplayer_menu := preload("res://ui/MultiplayerMenu/multiplayer_menu.tscn")

@onready var singeplayer_button := $VBoxContainer/Singleplayer
@onready var multiplayer_button := $VBoxContainer/Multiplayer
@onready var options_button := $VBoxContainer/Options
@onready var quit_button := $VBoxContainer/Quit
@onready var version_label := $VersionLabel


func _ready() -> void:
	singeplayer_button.connect("pressed", _on_singleplayer_button_pressed)
	multiplayer_button.connect("pressed", _on_multiplayer_button_pressed)
	options_button.connect("pressed", _on_options_button_pressed)
	quit_button.connect("pressed", func(): get_tree().quit())
	_set_version_label()
	singeplayer_button.grab_focus()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_ESCAPE:
				get_viewport().set_input_as_handled()
				print("TODO: Ask player if they want to exit to desktop")


func _set_version_label() -> void:
	var version_string := ""
	if OS.has_feature("debug"):
		if OS.has_feature("windows"):
			version_string = "Windows Debug Build"
		else:
			version_string = "Debug Build"
	elif OS.has_feature("release"):
		version_string = "Pre-Alpha Release"
	version_label.text = version_string


func _on_singleplayer_button_pressed() -> void:
	get_parent().add_child(singeplayer_menu.instantiate())


func _on_multiplayer_button_pressed() -> void:
	get_parent().add_child(multiplayer_menu.instantiate())


func _on_options_button_pressed() -> void:
	get_parent().add_child(options_menu.instantiate())
