extends Node3D

signal world_exited

enum Gamemode {SURVIVAL, CREATIVE, SPECTATOR}

var gamemode := Gamemode.CREATIVE

func _ready() -> void:
	if gamemode == Gamemode.SPECTATOR:
		const Freecam := preload("res://world/freecam/freecam.tscn")
		add_child(Freecam.instantiate())
	elif gamemode == Gamemode.CREATIVE:
		const Player := preload("res://world/player/player.tscn")
		var player := Player.instantiate()
		player.set_terrain($VoxelTerrain)
		add_child(player)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		_save_and_exit()

func _save_and_exit() -> void:
	var voxel_terrain := $VoxelTerrain as VoxelTerrain
	var progress := voxel_terrain.save_modified_blocks()
	while not progress.is_complete():
		pass
	world_exited.emit()
