extends Control

var options_menu := preload("res://ui/OptionsMenu/options_menu.tscn")

@onready var resume_button := $VBoxContainer/Button
@onready var options_button := $VBoxContainer/Button2
@onready var quit_button := $VBoxContainer/Button3


func _ready() -> void:
	resume_button.connect("pressed", Callable(self, "_on_resume_button_pressed"))
	options_button.connect("pressed", Callable(self, "_on_options_button_pressed"))
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


func _on_options_button_pressed() -> void:
	var menu = options_menu.instantiate()
	add_child(menu)


func close_menu() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	queue_free()

