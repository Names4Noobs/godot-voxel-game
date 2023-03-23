class_name CameraSwitcher
extends Node

signal freecam_toggled(enabled: bool)
signal perspective_toggled(perspective: int)

enum Perspective {FIRST_PERSON, THIRD_PERSON_FRONT, THIRD_PERSON_BACK}

@export var first_person_camera: Camera3D
@export var third_person_front_camera: Camera3D
@export var third_person_back_camera: Camera3D
@export var free_camera: Camera3D

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
	current_perspective = Perspective.FIRST_PERSON


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("toggle_perspective"):
		if freecam_enabled:
			return
		change_perspective(wrapi(current_perspective+1, 0, 3))
	elif Input.is_action_just_released("toggle_freecam"):
		if not free_camera:
			push_error("free camera is null")
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
		free_camera.global_position = get_parent().global_position
		free_camera.current = true
		freecam_enabled = true
	else:
		change_perspective(current_perspective)
		freecam_enabled = false


func change_perspective(new_perspective: int) -> void:
	match new_perspective:
		Perspective.FIRST_PERSON:
			if not first_person_camera:
				return
			first_person_camera.current = true
		Perspective.THIRD_PERSON_FRONT:
			if not third_person_front_camera:
				return
			third_person_front_camera.current = true
		Perspective.THIRD_PERSON_BACK:
			if not third_person_back_camera:
				return
			third_person_back_camera.current = true
	current_perspective = new_perspective
