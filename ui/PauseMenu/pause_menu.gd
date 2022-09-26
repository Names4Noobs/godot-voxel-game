extends Control

var options_menu := preload("res://ui/OptionsMenu/options_menu.tscn")
var multiplayer_menu := preload("res://ui/MultiplayerMenu/multiplayer_menu.tscn")
var title_screen := preload("res://ui/TitleScreen/title_screen.tscn")

@onready var resume_button: Button = $VBoxContainer/ResumeButton
@onready var settings_button: Button = $VBoxContainer/SettingsButton
@onready var quit_button: Button = $VBoxContainer/QuitToTitle


func _ready() -> void:
	resume_button.connect("pressed", _on_resume_button_pressed)
	settings_button.connect("pressed", _on_settings_button_pressed)
	quit_button.connect("pressed", _on_quit_to_title_pressed)
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

func _on_quit_to_title_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(title_screen)

func close_menu() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	queue_free()
