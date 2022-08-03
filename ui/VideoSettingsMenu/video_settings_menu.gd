extends Control


enum ResolutionOptions {RES_1024x600, RES_1920x1080}
enum WindowOptions {WINDOWED, BORDERLESS, FULLSCREEN}
enum GUIScaleOptions {SCALE_1X, SCALE_2X}

@onready var fov_slider: HSlider = $MarginContainer/VBoxContainer/FOVContainer/FOVSlider
@onready var fov_text: Label = $MarginContainer/VBoxContainer/FOVContainer/Label
@onready var resolution_button: OptionButton = $MarginContainer/VBoxContainer/ResolutionContainer/OptionButton
@onready var window_mode_button: OptionButton = $MarginContainer/VBoxContainer/WindowContainer/OptionButton
@onready var gui_scale_button: OptionButton = $MarginContainer/VBoxContainer/GUIContainer/OptionButton


func _ready() -> void:
	fov_slider.connect("value_changed", Callable(self, "_on_fov_slider_value_changed"))
	resolution_button.connect("item_selected", Callable(self, "_on_resolution_button_item_selected"))
	window_mode_button.connect("item_selected", Callable(self, "_on_window_mode_button_item_selected"))
	gui_scale_button.connect("item_selected", Callable(self, "_on_gui_scale_button_item_selected"))
	fov_slider.value = 70.0
	fov_text.set_text("FOV: " + str(70.0))


func _on_fov_slider_value_changed(value: float) -> void:
	fov_text.set_text("FOV: " + str(value))


# TODO: Change the resolution
# This just changes the window size not the rendered resolution
func _on_resolution_button_item_selected(index: int) -> void:
	match index:
		ResolutionOptions.RES_1024x600:
			DisplayServer.window_set_size(Vector2i(1024, 600))
		ResolutionOptions.RES_1920x1080:
			DisplayServer.window_set_size(Vector2i(1920, 1080))


func _on_window_mode_button_item_selected(index: int) -> void:
	match index:
		WindowOptions.WINDOWED:
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		WindowOptions.BORDERLESS:
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		WindowOptions.FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		


func _on_gui_scale_button_item_selected(_index: int) -> void:
	pass
