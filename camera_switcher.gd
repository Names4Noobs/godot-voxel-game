extends Node
#@onready var current_camera = get_viewport().get_camera_3d()

@onready var camera1 = get_node("../FreeLookCamera")
@onready var camera2 = get_node("../CharacterBody3D/Node3D/Camera3D")

# TODO: Player body needs to be disabled when the cameras are switched



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("switch_camera"):
		if camera1.current:
			camera2.set_current(true)
		elif camera2.current:
			camera1.set_current(true)
