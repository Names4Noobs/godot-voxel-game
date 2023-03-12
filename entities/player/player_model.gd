extends Node3D


func _ready() -> void:
	Game.connect("camera_changed", _on_camera_changed)
	_on_camera_changed(get_parent().get_camera_switcher().camera_type)

func _on_camera_changed(camera_type: int) -> void:
	match camera_type: 
		Game.CameraType.FIRST_PERSON:
			hide()
		_:
			show()
