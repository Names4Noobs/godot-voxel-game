# This node manages mob spawning
extends Node


var cow := preload("res://entities/cow.tscn")

@export_node_path(CharacterBody3D) var player_path = NodePath("../CharacterBody3D")
@onready var player = get_node(player_path)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_G:
				print("You just spawned a cow!")
				_spawn_cow()


func _spawn_cow() -> void:
	var entity = cow.instantiate()
	entity.position = player.position
	add_child(entity)
