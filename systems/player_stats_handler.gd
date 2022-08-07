extends Node

var fall_start_position = null


@onready var player: CharacterBody3D = get_parent()
@onready var feet: Node3D = get_node("../Feet")
@onready var stamina_regen_cooldown: Timer = $StaminaRegenCooldown
@onready var stamina_regen_speed: Timer = $StaminaRegenSpeed



func _ready() -> void:
	stamina_regen_cooldown.connect("timeout", Callable(self, "_on_stamina_regen_cooldown_timeout"))
	stamina_regen_speed.connect("timeout", Callable(self, "_on_stamina_regen_speed_timeout"))
	player = get_parent()
	stamina_regen_cooldown.wait_time = player.data.stats.stamina_regen_cooldown
	stamina_regen_speed.wait_time = player.data.stats.stamina_regen_speed
	Signals.connect("player_falling", Callable(self, "_on_player_falling"))
	Signals.connect("player_fell", Callable(self, "_on_player_fell"))
	Signals.connect("player_sprint_state_changed", Callable(self, "_on_player_sprint_state_changed"))


func _on_player_falling() -> void:
	if fall_start_position == null:
		fall_start_position = feet.get_global_position().y


func _on_player_fell() -> void:
	var distance = int(fall_start_position - feet.get_global_position().y)
	fall_start_position = null
	if distance <= 0:
		return
	_damage_player_on_fall(distance)


func _damage_player_on_fall(distance: int) -> void:
	var fall_damage := (distance-3) * 5
	if fall_damage >= 0:
		Signals.emit_signal("player_damage", fall_damage)

func _on_player_sprint_state_changed(is_sprinting: bool) -> void:
	if !is_sprinting and player.data.stats.stamina < 100:
		if stamina_regen_cooldown.is_stopped():
			stamina_regen_cooldown.start()


func _on_stamina_regen_cooldown_timeout() -> void:
	if stamina_regen_speed.is_stopped() and player.data.stats.stamina < 100:
		player.data.stats.stamina += 1
		stamina_regen_speed.start()


func _on_stamina_regen_speed_timeout() -> void:
	if player.data.stats.stamina < 100 and player.data.stats.stamina > 0:
		player.data.stats.stamina += 1
		stamina_regen_speed.start()
	elif player.data.stats.stamina <= 0:
		if stamina_regen_cooldown.is_stopped():
			stamina_regen_cooldown.start()
