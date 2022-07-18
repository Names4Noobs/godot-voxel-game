extends Node


@onready var freelook_camera = get_node("../FreeLookCamera")
@onready var firstperson_camera = get_node("../CharacterBody3D/Node3D/Camera3D")


# TODO: Player body needs to be disabled when the cameras are switched
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("switch_camera"):
		if freelook_camera.current:
			freelook_camera.set_process(false)
			firstperson_camera.get_parent().get_parent().set_process(true)
			firstperson_camera.set_current(true)
			
		elif firstperson_camera.current:
			firstperson_camera.get_parent().get_parent().set_process(false)
			freelook_camera.set_process(true)
			freelook_camera.set_current(true)

