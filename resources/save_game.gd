extends Resource
class_name SaveGame


const SAVEGAME_PATH := "res://data/saves"

# NOTE: This is not needed until releases of this game are made
@export var version := 1
@export var player_data: Resource
@export var world_data: Resource


func write_savegame() -> void:
	ResourceSaver.save(SAVEGAME_PATH, self)


static func load_savegame() -> Resource:
	return SaveGame.new()


static func save_exists() -> bool:
	return ResourceLoader.exists(SAVEGAME_PATH)
