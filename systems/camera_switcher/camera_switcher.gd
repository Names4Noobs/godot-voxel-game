extends Node


@export var first_person_camera: Camera3D
@export var third_person_front_camera: Camera3D
@export var third_person_back_camera: Camera3D
@export var free_camera: Camera3D

var player: Player

var camera_type: int:
	set(v):
		camera_type = v
		if camera_type != Game.CameraType.FREE_CAM:
			current_perspective = camera_type
		Game.emit_signal("camera_changed", camera_type)

var free_cam_enabled := false
var current_perspective: int 


func _ready() -> void:
	player = get_parent()
	camera_type = Game.CameraType.FIRST_PERSON


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("toggle_perspective"):
		if free_cam_enabled:
			return
		switch_camera(wrapi(camera_type+1, 0, 3))
	elif Input.is_action_just_released("toggle_freecam"):
		if free_cam_enabled:
			switch_camera(current_perspective)
		else:
			switch_camera(Game.CameraType.FREE_CAM)


func switch_camera(new_camera_type: int) -> void:
	camera_type = new_camera_type
	player.is_input_disabled = false
	free_cam_enabled = false
	free_camera.global_position = player.global_position
	match camera_type:
		Game.CameraType.FIRST_PERSON:
			if first_person_camera == null:
				return
			first_person_camera.current = true
		Game.CameraType.THIRD_PERSON_FRONT:
			if third_person_front_camera == null:
				return
			third_person_front_camera.current = true
		Game.CameraType.THIRD_PERSON_BACK:
			if third_person_back_camera == null:
				return
			third_person_back_camera.current = true
		Game.CameraType.FREE_CAM:
			if free_camera == null:
				return
			player.is_input_disabled = true
			free_camera.current = true
			free_cam_enabled = true
