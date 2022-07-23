extends Control


@onready var resume_button := $VBoxContainer/Button
@onready var options_button := $VBoxContainer/Button2
@onready var quit_button := $VBoxContainer/Button3


func _ready() -> void:
	resume_button.connect("pressed", Callable(self, "_on_resume_button_pressed"))
	options_button.connect("pressed", Callable(self, "_on_options_button_pressed"))
	quit_button.connect("pressed", Callable(func(): get_tree().quit()))
	get_tree().paused = true
	resume_button.grab_focus()


func _on_resume_button_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	queue_free()



func _on_options_button_pressed() -> void:
	pass
