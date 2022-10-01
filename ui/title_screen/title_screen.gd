extends Control

var splash_texts: Array[String] = ["Definitely not minecraft", "New and improved!", "Ad infinitum"]

var singeplayer_menu := preload("res://ui/singleplayer_menu/singleplayer_menu.tscn")
var options_menu := preload("res://ui/options_menu/options_menu.tscn")
var multiplayer_menu := preload("res://ui/multiplayer_menu/multiplayer_menu.tscn")

@onready var singeplayer_button := $VBoxContainer/Singleplayer
@onready var multiplayer_button := $VBoxContainer/Multiplayer
@onready var options_button := $VBoxContainer/Options
@onready var quit_button := $VBoxContainer/Quit
@onready var version_label := $VersionLabel
@onready var exit_dialog: ConfirmationDialog = $ExitConfirmationDialog
@onready var splash_text := $SplashText


func _ready() -> void:
	singeplayer_button.connect("pressed", _on_singleplayer_button_pressed)
	multiplayer_button.connect("pressed", _on_multiplayer_button_pressed)
	options_button.connect("pressed", _on_options_button_pressed)
	quit_button.connect("pressed", func(): get_tree().quit())
	exit_dialog.get_ok_button().connect("pressed", _on_exit_dialog_pressed)
	_setup_exit_dialog()
	_set_splash_text()
	_set_version_label()
	singeplayer_button.grab_focus()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_ESCAPE:
				get_viewport().set_input_as_handled()
				exit_dialog.popup_centered()

func _set_splash_text() -> void:
	splash_texts.shuffle()
	splash_text.text = "[center][wave][color=yellow]%s[/color][/wave][/center]" % splash_texts[0]



# NOTE: Eventually this shouldn't be needed
func _setup_exit_dialog() -> void:
	var label_settings = LabelSettings.new()
	label_settings.font_size = 32
	var label = exit_dialog.get_label()
	label.label_settings = label_settings

func _set_version_label() -> void:
	var version_string := ""
	if OS.has_feature("debug"):
		if OS.has_feature("windows"):
			version_string = "Windows Debug Build"
		else:
			version_string = "Debug Build"
	elif OS.has_feature("release"):
		version_string = "Pre-Alpha Release"
	version_label.text = version_string

func _on_exit_dialog_pressed() -> void:
	get_tree().quit()

func _on_singleplayer_button_pressed() -> void:
	get_parent().add_child(singeplayer_menu.instantiate())


func _on_multiplayer_button_pressed() -> void:
	get_parent().add_child(multiplayer_menu.instantiate())


func _on_options_button_pressed() -> void:
	get_parent().add_child(options_menu.instantiate())
