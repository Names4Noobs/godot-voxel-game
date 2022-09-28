extends Control

@onready var join_server_button := $VBoxContainer2/JoinServer
@onready var cancel_button := $VBoxContainer2/Cancel

func _ready() -> void:
	join_server_button.connect(&"pressed", _on_join_server_button_pressed)
	cancel_button.connect(&"pressed", _on_cancel_button_pressed)


func _on_join_server_button_pressed() -> void:
	pass


func _on_cancel_button_pressed() -> void:
	queue_free()
