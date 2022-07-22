extends Node

var death_screen = preload("res://ui/death_screen.tscn")

@export_node_path(CharacterBody3D) var player_path = NodePath("../CharacterBody3D")
@onready var player = get_node(player_path)


func _ready() -> void:
	Signals.connect("player_died", Callable(self, "_on_player_died"))
	Signals.connect("player_respawned", Callable(self, "_on_player_respawned"))
	Signals.connect("player_out_of_stamina", Callable(self, "_on_player_out_of_stamina"))
	player.position = Vector3(25, 2, 0)


# NOTE: This is for testing
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_F:
				_on_player_died()


func _on_player_died() -> void:
	var screen = death_screen.instantiate()
	add_child(screen)


func _on_player_respawned() -> void:
	player.position = Vector3(25, 2, 0)
	player.data.stats = PlayerStats.new()


# This needs to be moved to a player stats manager
# Also, this is terrible; remove it.
var process = true
var stamina_cooldown := 8.0
func _on_player_out_of_stamina() -> void:
	if player.data.stats.stamina != 0:
		return
	if process:
		process = false
		await get_tree().create_timer(stamina_cooldown).timeout
		player.data.stats.stamina = 100
		player.data.stats.can_sprint = true
		process = true
