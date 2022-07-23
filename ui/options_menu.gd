extends Control

@onready var name_text_edit := $HBoxContainer/TextEdit
@onready var fullscreen_toggle_button := $HBoxContainer2/Toggle
@onready var video_button := $VBoxContainer/Button
@onready var inputs_button := $VBoxContainer/Button2

func _ready() -> void:
	video_button.grab_focus()
	name_text_edit.text = "Bob"
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()
