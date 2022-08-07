extends Node

const FULLSCREEN_DEFAULT := false
const WINDOW_SIZE_DEFAULT := Vector2i(1024, 600)

var fullscreen := false:
	set(v):
		if v:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = v

var borderless := false:
	set(v):
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, v)
			borderless = v

var window_size: Vector2i:
	set(v):
		DisplayServer.window_set_size(v)
		window_size = v

var _config := ConfigFile.new()


func _ready() -> void:
	_config.load("user://config.ini")
	if _config.has_section("Display"):
		if _config.has_section_key("Display", "fullscreen"):
			var result = _config.get_value("Display", "fullscreen")
			assert(result is bool)
			fullscreen = result
		else:
			_config.set_value("Display", "fullscreen", FULLSCREEN_DEFAULT)
		if _config.has_section_key("Display", "window_size"):
			var result = _config.get_value("Display", "window_size")
			assert(result is Vector2i)
			window_size = result
		else:
			_config.set_value("Display", "window_size", WINDOW_SIZE_DEFAULT)
	else:
		_config.set_value("Display", "fullscreen", FULLSCREEN_DEFAULT)
		_config.set_value("Display", "window_size", WINDOW_SIZE_DEFAULT)
	_config.save("user://config.ini")


func _exit_tree() -> void:
	if _config.has_section("Display"):
		if _config.has_section_key("Display", "fullscreen"):
			_config.set_value("Display", "fullscreen", fullscreen)
	_config.save("user://config.ini")
