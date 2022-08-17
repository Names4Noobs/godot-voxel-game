extends Control

@onready var back_button = $Button

func _ready() -> void:
	back_button.connect("pressed", _on_back_button_pressed)
	back_button.grab_focus()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		queue_free()


func _on_back_button_pressed() -> void:
	queue_free()
