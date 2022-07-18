extends Node3D

const MyGenerator = preload("res://misc/voxel_generator.gd")

var savegame: Resource
# NOTE: This is just for testing!!
var death_screen = preload("res://ui/death_screen.tscn")
var inventory_screen = preload("res://ui/inventory.tscn")

@onready var terrain: VoxelTerrain = $VoxelTerrain


func _ready() -> void:
	_load_or_create()
	terrain.generator = MyGenerator.new()

# NOTE: This is just for testing!!
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_F:
				Signals.emit_signal("player_died")
				_on_player_died()
	if Input.is_action_just_pressed("open_inventory"):
		# TODO: Make the menu toggle in a better way
		if get_node("InventoryMenu") == null:
			var screen = inventory_screen.instantiate()
			add_child(screen)


# NOTE: This is just for testing!!
func _on_player_died() -> void:
	var screen = death_screen.instantiate()
	add_child(screen)


func _load_or_create() -> void:
	if SaveGame.save_exists():
		savegame = SaveGame.load_savegame()
	else:
		print("Savegame does not exist!")


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_CLOSE_REQUEST:
			# TODO: Update savegame before the save is written!
			savegame.write_savegame()
