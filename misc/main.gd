extends Node3D

const MyGenerator = preload("res://misc/voxel_generator.gd")

var savegame: Resource

# NOTE: This is just for testing!!
var inventory_screen := preload("res://ui/inventory.tscn")
var inventory_screen_enabled := false
var pause_screen := preload("res://ui/pause_menu.tscn")


@onready var terrain: VoxelTerrain = $VoxelTerrain


func _ready() -> void:
	_load_or_create()
	terrain.generator = MyGenerator.new()


# NOTE: This is just for testing!!
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_ESCAPE:
				var menu = pause_screen.instantiate()
				add_child(menu)
	if Input.is_action_just_pressed("open_inventory"):
		if inventory_screen_enabled == false:
			var screen = inventory_screen.instantiate()
			add_child(screen)
		inventory_screen_enabled = !inventory_screen_enabled

func _load_or_create() -> void:
	if SaveGame.save_exists():
		savegame = SaveGame.load_savegame()
#		$WorldLogic.world_data = savegame.world_data
#		$CharacterBody3D.data = savegame.player_data
	else:
		print("Savegame does not exist!")
		savegame = SaveGame.new()


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_CLOSE_REQUEST:
			# TODO: Update savegame before the save is written!
			_save_game()
			savegame.write_savegame()


func _save_game() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		savegame.player_data = node.data
	savegame.world_data = $WorldLogic.world_data
