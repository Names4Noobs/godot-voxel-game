extends Node


const PLAYER_NAME_DEFAULT = "Bob"
const FULLSCREEN_DEFAULT := false
const BORDERLESS_DEFAULT := false
const WINDOW_SIZE_DEFAULT := Vector2i(1024, 600)
const MASTER_VOLUME_DEFAULT := 1.0
const UI_VOLUME_DEFAULT := 1.0

var fullscreen := FULLSCREEN_DEFAULT:
	set(v):
		if v:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = v

var borderless := BORDERLESS_DEFAULT:
	set(v):
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, v)
			borderless = v

var window_size: Vector2i:
	set(v):
		DisplayServer.window_set_size(v)
		window_size = v

var master_volume: float:
	set(v):
		v = clampf(v, 0.0, 1.0)
		AudioServer.set_bus_volume_db(0, linear2db(v))
		master_volume = v

var ui_volume: float:
	set(v):
		v = clampf(v, 0.0, 1.0)
		AudioServer.set_bus_volume_db(1, linear2db(v))
		ui_volume = v

var player_name: String = PLAYER_NAME_DEFAULT

var _config := ConfigFile.new()


func _ready() -> void:
	_config.load("user://config.ini")
	if _config.has_section_key("Profile", "player_name"):
		var result = _config.get_value("Profile", "player_name")
		assert(result is String)
		player_name = result
	else:
		_config.set_value("Profile", "player_name", PLAYER_NAME_DEFAULT)
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
	if _config.has_section_key("Display", "borderless"):
		var result = _config.get_value("Display", "borderless")
		assert(result is bool)
		borderless = result
	else:
		_config.set_value("Display", "borderless", BORDERLESS_DEFAULT)
	if _config.has_section_key("Audio", "master_volume"):
		var result = _config.get_value("Audio", "master_volume")
		assert(result is float)
		master_volume = result
	else:
		_config.set_value("Audio", "master_volume", MASTER_VOLUME_DEFAULT)
	if _config.has_section_key("Audio", "ui_volume"):
		var result = _config.get_value("Audio", "ui_volume")
		assert(result is float)
		ui_volume = result
	else:
		_config.set_value("Audio", "ui_volume", UI_VOLUME_DEFAULT)
	_config.save("user://config.ini")
	

func _exit_tree() -> void:
	if _config.has_section_key("Display", "fullscreen"):
		_config.set_value("Display", "fullscreen", fullscreen)
	if _config.has_section_key("Display", "borderless"):
		_config.set_value("Display", "borderless", borderless)
	if _config.has_section_key("Audio", "master_volume"):
		_config.set_value("Audio", "master_volume", db2linear(AudioServer.get_bus_volume_db(0)))
	if _config.has_section_key("Audio", "ui_volume"):
		_config.set_value("Audio", "ui_volume", db2linear(AudioServer.get_bus_volume_db(1)))
	if _config.has_section_key("Profile", "player_name"):
		_config.set_value("Profile", "player_name", player_name)
	_config.save("user://config.ini")
