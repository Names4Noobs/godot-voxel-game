extends Button


# TODO: Eventually their will be an audio singleton which manages it
@onready var tick_audio: AudioStreamPlayer = get_node("../TickAudio")


func _ready() -> void:
	connect("mouse_entered", Callable(func(): tick_audio.play()))
	connect("focus_entered", Callable(func(): tick_audio.play()))
