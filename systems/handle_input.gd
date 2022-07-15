# This node is for inputs that always need to be processed even when paused
extends Node


var fullscreen = false:
	set(v):
		if v == true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = v


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_fullscreen"):
		fullscreen = !fullscreen

