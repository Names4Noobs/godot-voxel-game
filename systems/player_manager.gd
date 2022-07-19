extends Node

var death_screen = preload("res://ui/death_screen.tscn")

@onready var player = get_node("../CharacterBody3D")


func _ready() -> void:
	Signals.connect("player_died", Callable(self, "_on_player_died"))
	Signals.connect("player_respawned", Callable(self, "_on_player_respawned"))


func _on_player_died() -> void:
	var screen = death_screen.instantiate()
	add_child(screen)


func _on_player_respawned() -> void:
	player.position = Vector3(25, 0, 0)
	player.data.stats = PlayerStats.new()
