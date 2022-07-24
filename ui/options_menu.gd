extends Control

@onready var name_text_edit := $HBoxContainer/TextEdit
@onready var fullscreen_toggle_button := $HBoxContainer2/Toggle
@onready var general_button := $VBoxContainer/Button3
@onready var video_button := $VBoxContainer/Button
@onready var controls_button := $VBoxContainer/Button2
@onready var back_button := $MenuTopBar/Button


func _ready() -> void:
	back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))
	back_button.grab_focus()
	name_text_edit.text = "Bob"


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()


func _on_back_button_pressed() -> void:
	queue_free()
