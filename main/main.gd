## Main entry point of the game
extends Node

func _ready() -> void:
	var args := _parse_user_args()
	# Immediately load world; skip main menu
	if "save" in args:
		_load_save(args["save"])
		return
	else:
		_add_title_screen()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released(&"toggle_fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	elif Input.is_action_just_released(&"take_screenshot"):
		_take_screenshot()


func _take_screenshot() -> void:
	var time := Time.get_datetime_dict_from_system()
	var ss_path := (
		"user://%s-%s-%s_%s.%s.%s.png" % [time["year"], time["month"], 
		time["day"], time["hour"], time["minute"], time["second"]]
	)
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png(ss_path)
	print("Saving screenshot to %s." % ss_path)



func _load_save(save_name: StringName) -> bool:
	const WorldScene := preload("res://world/world.tscn")
	print("Loading save %s..." % save_name)
	# Load the world scene
	var world := WorldScene.instantiate()
	world.connect(&"world_exited", func(): 
		if not has_node(^"TitleScreen"):
			_add_title_screen()
		get_node(^"TitleScreen").show()
		world.queue_free())
	add_child(world)
	# Loading successful
	return true


func _add_title_screen() -> void:
	const TitleScreen := preload("res://title_screen/title_screen.tscn")
	var title_scr := TitleScreen.instantiate()
	title_scr.connect(&"singleplayer_pressed", func(): 
		if _load_save(&""):
			title_scr.hide())
	add_child(title_scr)


func _parse_user_args() -> Dictionary:
	var args = {}
	for argument in OS.get_cmdline_user_args():
		if argument.contains("="):
			var key_value = argument.split("=")
			args[key_value[0].trim_prefix("--")] = key_value[1]
		else:
			# Options without an argument will be present in the dictionary,
			# with the value set to an empty string.
			args[argument.trim_prefix("--")] = ""
	return args
