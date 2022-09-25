extends Control


var singeplayer_menu := preload("res://ui/SingleplayerMenu/singleplayer_menu.tscn")
var options_menu := preload("res://ui/OptionsMenu/options_menu.tscn")

@onready var singeplayer_button := $VBoxContainer/Singleplayer
@onready var multiplayer_button := $VBoxContainer/Multiplayer
@onready var options_button := $VBoxContainer/Options
@onready var quit_button := $VBoxContainer/Quit


func _ready() -> void:
	singeplayer_button.connect("pressed", _on_singleplayer_button_pressed)
	multiplayer_button.connect("pressed", _on_multiplayer_button_pressed)
	options_button.connect("pressed", _on_options_button_pressed)
	quit_button.connect("pressed", func(): get_tree().quit())


func _on_singleplayer_button_pressed() -> void:
	get_parent().add_child(singeplayer_menu.instantiate())



func _on_options_button_pressed() -> void:
	get_parent().add_child(options_menu.instantiate())


func _on_multiplayer_button_pressed() -> void:
	pass
