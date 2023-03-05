extends Node

signal value_empty


var max_value = 20.0

var regeneration_cooldown := 2.0
var regeneration_speed := 0.1
var regeneration_amount := 1.0
var can_regenerate := true
var is_regenerating := false


@export var value: float:
	set(v):
		value = clampf(v, 0, max_value)
		if value == 0:
			emit_signal("value_empty")
		elif value == max_value:
			is_regenerating = false

@onready var regeneration_cooldown_timer := $CooldownTimer
@onready var regeneration_speed_timer := $SpeedTimer


func _ready() -> void:
	regeneration_cooldown_timer.connect("timeout", _on_regeneration_cooldown_timeout)
	regeneration_speed_timer.connect("timeout", _on_regeneration_speed_timeout)
	
	value = max_value
	regeneration_cooldown_timer.wait_time = regeneration_cooldown
	regeneration_speed_timer.wait_time = regeneration_speed


func start_cooldown_timer() -> void:
	if can_regenerate and is_not_max():
		if not is_regenerating and regeneration_cooldown_timer.is_stopped():
			regeneration_cooldown_timer.start()


func is_not_max() -> bool:
	return value < max_value


func _on_regeneration_cooldown_timeout() -> void:
	is_regenerating = true
	while is_regenerating:
		regeneration_speed_timer.start()
		await regeneration_speed_timer.timeout


func _on_regeneration_speed_timeout() -> void:
	if is_regenerating:
		value += regeneration_amount
