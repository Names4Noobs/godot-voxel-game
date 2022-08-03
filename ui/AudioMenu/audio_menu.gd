extends Control
# TODO: Make an audio slider node

var master_audio_bus := &"Master"
var master_bus_index = AudioServer.get_bus_index(master_audio_bus)
var ui_audio_bus := &"UI"
var ui_bus_index = AudioServer.get_bus_index(ui_audio_bus)


@onready var mute_button: CheckButton = $MarginContainer/VBoxContainer/CheckButton
@onready var master_volume_slider: HSlider = $MarginContainer/VBoxContainer/MasterVolume/HSlider
@onready var master_volume_label: Label = $MarginContainer/VBoxContainer/MasterVolume/Label
@onready var ui_volume_label: Label = $MarginContainer/VBoxContainer/UIVolume/Label
@onready var ui_volume_slider: HSlider = $MarginContainer/VBoxContainer/UIVolume/HSlider


func _ready() -> void:
	mute_button.connect("toggled", Callable(func(v): AudioServer.set_bus_mute(master_bus_index, v)))
	master_volume_slider.connect("value_changed", Callable(self, "_on_master_volume_changed"))
	master_volume_slider.value = db2linear(AudioServer.get_bus_volume_db(master_bus_index))
	master_volume_label.text = "Master Volume: " + str(master_volume_slider.value)
	ui_volume_slider.connect("value_changed", Callable(self, "_on_ui_volume_changed"))
	ui_volume_slider.value = db2linear(AudioServer.get_bus_volume_db(ui_bus_index))
	ui_volume_label.text = "UI Volume: " + str(ui_volume_slider.value)




func _on_master_volume_changed(value: float) -> void:
	master_volume_label.text = "Master Volume: " + str(value)
	AudioServer.set_bus_volume_db(master_bus_index, linear2db(value))


func _on_ui_volume_changed(value: float) -> void:
	ui_volume_label.text = "UI Volume: " + str(value)
	AudioServer.set_bus_volume_db(ui_bus_index, linear2db(value))
