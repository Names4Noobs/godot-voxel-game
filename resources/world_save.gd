extends Resource
class_name WorldSave


const SAVE_PATH := "user://saves/"
@export var world_name: String = "New World"
@export_file var world_icon: String = "res://assets/textures/block/dirt.png"
@export var world_scene_path: String = "res://systems/world/world.tscn"

func save_world() -> void:
	var file_path := SAVE_PATH + world_name + ".tres"
	ResourceSaver.save(self, file_path.to_snake_case())
