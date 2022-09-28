extends HBoxContainer

@onready var events_button := $Button
@onready var action_label := $Label


func _ready() -> void:
	events_button.connect("pressed", _on_events_button_pressed)


func _on_events_button_pressed() -> void:
	OS.alert(events_button.text)
