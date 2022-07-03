extends Control

@onready var debug_info: Control = $MonitorOverlay


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_hud"):
		hide() if visible else show()
	elif Input.is_action_just_pressed("toggle_debug_info"):
		debug_info.hide() if debug_info.visible else debug_info.show()
