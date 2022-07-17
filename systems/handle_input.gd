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
	elif Input.is_action_just_pressed("take_screenshot"):
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png("user://%s-screenshot.png" % Time.get_date_string_from_system())
