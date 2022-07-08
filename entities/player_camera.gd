#Copyright © 2022 Marc Nahr: https://github.com/MarcPhi/godot-free-look-camera
extends Camera3D

@export_range(0, 10, 0.01) var sensitivity : float = 3
@onready var head = get_parent()



func _ready() -> void:
	if current:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED



func _input(event: InputEvent):
	if not current:
		return

	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED)


	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			head.rotation.y -= event.relative.x / 1000 * sensitivity
			head.rotation.x -= event.relative.y / 1000 * sensitivity
			head.rotation.x = clamp(head.rotation.x, PI/-2, PI/2)
	

