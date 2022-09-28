extends Node


var freelook_camera := preload("res://misc/free_look_camera/free_look_camera.tscn")
var cam: Camera3D
var using_freelook := false

@onready var firstperson_camera: Camera3D = get_node("../CharacterBody3D/Node3D/Camera3D")
@onready var player: CharacterBody3D = get_node("../CharacterBody3D")
@onready var player_model = player.get_node("basicCharacter")


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("switch_camera"):
		if using_freelook:
			player.set_physics_process(true)
			firstperson_camera.set_process_input(true)
			firstperson_camera.make_current()
			player_model.visible = false
			cam.queue_free()
		else:
			player.set_physics_process(false)
			firstperson_camera.set_process_input(false)
			cam = freelook_camera.instantiate()
			cam.make_current()
			player_model.visible = true
			add_child(cam)
		using_freelook = !using_freelook

