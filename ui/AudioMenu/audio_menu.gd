extends Control


var master_audio_bus := &"Master"
var master_bus_index = AudioServer.get_bus_index(master_audio_bus)

@onready var mute_button: CheckButton = $VBoxContainer/CheckButton
@onready var master_volume_slider: HSlider = $VBoxContainer/VBoxContainer/HSlider
@onready var master_volume_label: Label = $VBoxContainer/VBoxContainer/Label


func _ready() -> void:
	mute_button.connect("toggled", Callable(func(v): AudioServer.set_bus_mute(master_bus_index, v)))
	master_volume_slider.connect("value_changed", Callable(self, "_on_master_volume_changed"))
	master_volume_slider.value = db2linear(AudioServer.get_bus_volume_db(master_bus_index))
	master_volume_label.text = "Master Volume: " + str(master_volume_slider.value)


func _on_master_volume_changed(value: float) -> void:
	master_volume_label.text = "Master Volume: " + str(value)
	AudioServer.set_bus_volume_db(master_bus_index, linear2db(value))
