@tool
extends VBoxContainer

@export var audio_bus: StringName = &"Master":
	set(v):
		if Engine.is_editor_hint():
			label.set_text(_get_formated_string(1.0))
		else:
			_bus_index = AudioServer.get_bus_index(audio_bus)
		audio_bus = v

var _bus_index: int 

@onready var label: Label = $Label
@onready var slider: HSlider = $HSlider


func _ready() -> void:
	if !Engine.is_editor_hint():
		_bus_index = AudioServer.get_bus_index(audio_bus)
		slider.connect("value_changed", Callable(self, "_on_slider_value_changed"))
		_update_ui()


func _update_ui() -> void:
	var volume = db2linear(AudioServer.get_bus_volume_db(_bus_index))
	slider.value = volume
	label.set_text(_get_formated_string(volume))


func _on_slider_value_changed(value: float) -> void:
	label.text = _get_formated_string(value)
	AudioServer.set_bus_volume_db(_bus_index, linear2db(value))


func _get_formated_string(value: float) -> String:
	return str(audio_bus) + " Volume: " + str(value*100) +"%"
