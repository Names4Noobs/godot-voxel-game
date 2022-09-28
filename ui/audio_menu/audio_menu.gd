extends Control


var master_audio_bus := &"Master"
var master_bus_index = AudioServer.get_bus_index(master_audio_bus)

@onready var mute_button: CheckButton = $MarginContainer/VBoxContainer/CheckButton


func _ready() -> void:
	mute_button.connect("toggled", Callable(func(v): AudioServer.set_bus_mute(master_bus_index, v)))
