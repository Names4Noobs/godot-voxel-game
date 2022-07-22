# This node manages mob spawning
extends Node


var cow := preload("res://entities/cow.tscn")


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_G:
				print("You just spawned a cow!")
				_spawn_cow()


func _spawn_cow() -> void:
	var entity = cow.instantiate()
	entity.position = Vector3.ZERO
	add_child(entity)
