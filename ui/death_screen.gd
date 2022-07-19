extends Control


@onready var respawn_button = $VBoxContainer/Button
@onready var quit_button = $VBoxContainer/Button2


func _ready() -> void:
	respawn_button.connect("pressed", Callable(self, "_on_respawn_button_pressed"))
	quit_button.connect("pressed", Callable(func(): get_tree().quit()))
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true


func _on_respawn_button_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	Signals.emit_signal("player_respawned")
	queue_free()
