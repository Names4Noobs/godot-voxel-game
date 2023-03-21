class_name CameraSwitcher
extends Node

signal freecam_toggled(enabled: bool)
signal perspective_toggled(perspective: int)

enum Perspective {FIRST_PERSON, THIRD_PERSON_FRONT, THIRD_PERSON_BACK}

@export var first_person_camera: Camera3D
@export var third_person_front_camera: Camera3D
@export var third_person_back_camera: Camera3D
@export var free_camera: Camera3D

var player: Player

var freecam_enabled := false:
	set(v):
		freecam_enabled = v
		emit_signal("freecam_toggled", freecam_enabled)
var current_perspective: int:
	set(v):
		current_perspective = v
		emit_signal("perspective_toggled", current_perspective)

var is_zoomed := false

func _ready() -> void:
	player = get_parent()
	current_perspective = Perspective.FIRST_PERSON


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("toggle_perspective"):
		if freecam_enabled:
			return
		change_perspective(wrapi(current_perspective+1, 0, 3))
	elif Input.is_action_just_released("toggle_freecam"):
		if free_camera == null:
			return
		toggle_freecam()
	elif Input.is_action_just_pressed("zoom"):
		if is_zoomed:
			get_tree().create_tween() \
			.tween_property(get_viewport().get_camera_3d(), "fov", 75.0, 0.1)
			is_zoomed = false
		else:
			get_tree().create_tween() \
			.tween_property(get_viewport().get_camera_3d(), "fov", 10, 0.1)
			is_zoomed = true


func toggle_freecam() -> void:
	if not freecam_enabled:
		player.is_input_disabled = true
		free_camera.global_position = player.global_position
		free_camera.current = true
		freecam_enabled = true
	else:
		player.is_input_disabled = false
		change_perspective(current_perspective)
		freecam_enabled = false


func change_perspective(new_perspective: int) -> void:
	match new_perspective:
		Perspective.FIRST_PERSON:
			if first_person_camera == null:
				return
			first_person_camera.current = true
		Perspective.THIRD_PERSON_FRONT:
			if third_person_front_camera == null:
				return
			third_person_front_camera.current = true
		Perspective.THIRD_PERSON_BACK:
			if third_person_back_camera == null:
				return
			third_person_back_camera.current = true
	current_perspective = new_perspective
