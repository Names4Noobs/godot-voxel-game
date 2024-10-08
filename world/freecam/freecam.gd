# Modified version of
# Copyright © 2022 Marc Nahr: https://github.com/MarcPhi/godot-free-look-camera
extends Camera3D

@export_range(0, 10, 0.01) var sensitivity: float = 3
@export_range(0, 1000, 0.1) var default_velocity: float = 10
@export_range(0, 10, 0.01) var speed_scale: float = 1.17
@export var max_speed: float = 1000
@export var min_speed: float = 0.2

@onready var _velocity = default_velocity


func _ready() -> void:
	if current:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent):
	if not current:
		return
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotation.y -= event.relative.x / 1000 * sensitivity
			rotation.x -= event.relative.y / 1000 * sensitivity
			rotation.x = clamp(rotation.x, PI/-2, PI/2)
	
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP: # increase fly velocity
				_velocity = clamp(_velocity * speed_scale, min_speed, max_speed)
			MOUSE_BUTTON_WHEEL_DOWN: # decrease fly velocity
				_velocity = clamp(_velocity / speed_scale, min_speed, max_speed)


func _process(delta: float):
	var input_dir := Input.get_vector(
			&"move_left",
			&"move_right",
			&"move_forward",
			&"move_backward").normalized()
	translate(Vector3(input_dir.x, 0, input_dir.y) * _velocity * delta)
