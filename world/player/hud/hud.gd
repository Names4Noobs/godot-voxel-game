extends Control



func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"toggle_hud"):
		# This should not be a warning, but it is...
		hide() if visible else show()
