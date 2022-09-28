extends Control


enum ResolutionOptions {RES_1024x600, RES_1920x1080}
enum WindowOptions {WINDOWED, BORDERLESS, FULLSCREEN}
enum GUIScaleOptions {SCALE_1X, SCALE_2X}

@onready var fov_slider: HSlider = $FOVContainer/FOVSlider
@onready var fov_text: Label = $FOVContainer/Label
@onready var window_size_x: TextEdit = $VBoxContainer/WindowSizeContainer/HBoxContainer/XTextEdit
@onready var window_size_y: TextEdit = $VBoxContainer/WindowSizeContainer/HBoxContainer/YTextEdit
@onready var fullscreen_check: CheckBox = $VBoxContainer/FullscreenCheckBox
@onready var borderless_check: CheckBox = $VBoxContainer/BorderlessCheckBox


func _ready() -> void:
	fov_slider.connect("value_changed", Callable(self, "_on_fov_slider_value_changed"))
	fullscreen_check.connect("toggled", Callable(self, "_on_fullscreen_toggled"))
	borderless_check.connect("toggled", Callable(self, "_on_borderless_toggled"))
	fov_slider.value = 70.0
	fov_text.set_text("FOV: " + str(70.0))
	fullscreen_check.button_pressed = Settings.fullscreen
	borderless_check.button_pressed = Settings.borderless


func _on_fov_slider_value_changed(value: float) -> void:
	fov_text.set_text("FOV: " + str(value))


func _on_fullscreen_toggled(value: bool) -> void:
	Settings.fullscreen = value


func _on_borderless_toggled(value: bool) -> void:
	Settings.borderless = value
