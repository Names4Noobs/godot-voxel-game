extends Node3D

const MyGenerator = preload("res://generators/voxel_generator.gd")

var savegame: Resource

@onready var terrain: VoxelTerrain = $VoxelTerrain


func _ready() -> void:
	_load_or_create_savegame()
	terrain.generator = MyGenerator.new()


func _load_or_create_savegame() -> void:
	if SaveGame.save_exists():
		savegame = SaveGame.load_savegame()
#		$WorldLogic.world_data = savegame.world_data
#		$CharacterBody3D.data = savegame.player_data
	else:
		print("Savegame does not exist!")
		savegame = SaveGame.new()


func _save_game() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		savegame.player_data = node.data
	savegame.world_data = $WorldLogic.world_data


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_CLOSE_REQUEST:
			# TODO: Update savegame before the save is written!
			_save_game()
			savegame.write_savegame()
