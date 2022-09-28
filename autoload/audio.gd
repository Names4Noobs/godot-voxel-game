extends Node


func _ready() -> void:
	Signals.connect("eat_food", _on_eat_food)
	add_child(_create_sfx("eat", "res://assets/sfx/zapsplat_human_male_burp_very_short_85760.mp3"))

static func _create_sfx(sfx_name: String, path: String) -> AudioStreamPlayer:
	var audio := AudioStreamPlayer.new()
	audio.stream = load(path)
	audio.name = sfx_name
	return audio


func _on_eat_food() -> void:
	get_node("eat").play()
