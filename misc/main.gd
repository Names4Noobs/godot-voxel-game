extends Node3D

const MyGenerator = preload("res://misc/voxel_generator.gd")

@onready var terrain: VoxelTerrain = $VoxelTerrain

# NOTE: This is just for testing!!
var death_screen = preload("res://ui/death_screen.tscn")

func _ready() -> void:
	terrain.generator = MyGenerator.new()


# NOTE: This is just for testing!!
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_F:
				Signals.emit_signal("player_died")
				_on_player_died()


# NOTE: This is just for testing!!
func _on_player_died() -> void:
	var screen = death_screen.instantiate()
	add_child(screen)


