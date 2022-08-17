extends Control

var options_menu := preload("res://ui/OptionsMenu/options_menu.tscn")
var multiplayer_menu := preload("res://ui/MultiplayerMenu/multiplayer_menu.tscn")

@onready var resume_button: Button = $VBoxContainer/ResumeButton
@onready var new_game_button: Button = $VBoxContainer/NewGameButton
@onready var multiplayer_button: Button = $VBoxContainer/MultiplayerButton
@onready var settings_button: Button = $VBoxContainer/SettingsButton
@onready var quit_button: Button = $VBoxContainer/QuitButton


func _ready() -> void:
	resume_button.connect("pressed", _on_resume_button_pressed)
	new_game_button.connect("pressed", _on_new_game_button_pressed)
	multiplayer_button.connect("pressed", _on_multiplayer_button_pressed)
	settings_button.connect("pressed", _on_settings_button_pressed)
	quit_button.connect("pressed", Callable(func(): get_tree().quit()))
	get_tree().paused = true
	resume_button.grab_focus()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_ESCAPE:
				get_viewport().set_input_as_handled()
				close_menu()


func _on_resume_button_pressed() -> void:
	close_menu()


func _on_settings_button_pressed() -> void:
	var menu = options_menu.instantiate()
	add_child(menu)


func close_menu() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	queue_free()


func _on_new_game_button_pressed() -> void:
	pass


func _on_multiplayer_button_pressed() -> void:
	var menu = multiplayer_menu.instantiate()
	add_child(menu)
