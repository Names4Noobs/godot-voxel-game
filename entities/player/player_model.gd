extends Node3D


func _ready() -> void:
	var camera_switcher = get_parent().get_camera_switcher()
	camera_switcher.connect("freecam_toggled", _on_freecam_toggled)
	camera_switcher.connect("perspective_toggled", _on_perspective_toggled)
	_on_perspective_toggled(camera_switcher.current_perspective)

func _on_perspective_toggled(camera_type: int) -> void:
	match camera_type: 
		CameraSwitcher.Perspective.FIRST_PERSON:
			hide()
		_:
			show()

func _on_freecam_toggled(enabled: bool) -> void:
	if enabled and not visible:
		show()
