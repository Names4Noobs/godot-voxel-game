extends Control

signal singleplayer_pressed

@onready var singleplayer_btn := $VBoxContainer/Button

func _ready() -> void:
	visibility_changed.connect(func(): 
		if visible:
			singleplayer_btn.grab_focus.call_deferred()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	singleplayer_btn.grab_focus.call_deferred()
	$VBoxContainer/Button.connect(&"pressed", func(): singleplayer_pressed.emit())
	$VBoxContainer/Button3.connect(&"pressed", func(): get_tree().quit())
