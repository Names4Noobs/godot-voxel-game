# This node is for inputs that always need to be processed even when paused
extends Node


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_fullscreen"):
		Settings.fullscreen = !Settings.fullscreen
	elif Input.is_action_just_pressed("take_screenshot"):
		await RenderingServer.frame_post_draw
		var dir := Directory.new()
		if !dir.dir_exists("user://screenshots/"):
			dir.make_dir("user://screenshots/")
		var screenshot_string = "{year}-{month}-{day}_{hour}.{minute}.{second}"
		var formatted_string = screenshot_string.format(Time.get_datetime_dict_from_system())
		get_viewport().get_texture().get_image().save_png("user://screenshots/" + formatted_string + ".png")
