extends Node

var death_screen = preload("res://ui/death_screen.tscn")

@onready var player = get_node("../CharacterBody3D")


func _ready() -> void:
	Signals.connect("player_died", Callable(self, "_on_player_died"))
	Signals.connect("player_respawned", Callable(self, "_on_player_respawned"))
	Signals.connect("player_out_of_stamina", Callable(self, "_on_player_out_of_stamina"))
	player.position = Vector3(25, 2, 0)


func _on_player_died() -> void:
	var screen = death_screen.instantiate()
	add_child(screen)


func _on_player_respawned() -> void:
	player.position = Vector3(25, 2, 0)
	player.data.stats = PlayerStats.new()


# Yes, I know this is terrible
func _on_player_out_of_stamina() -> void:
	while player.data.stats.stamina < 100:
		await get_tree().create_timer(0.5).timeout
		player.data.stats.stamina += 1
