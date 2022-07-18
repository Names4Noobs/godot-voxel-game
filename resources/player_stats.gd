extends Resource
class_name PlayerStats

# Player stats
@export var health := 100:
	set(v):
		health = clampi(v, 0, 100)
		_check_if_dead()
@export var hunger := 100
@export var stamina := 5.0

func _init() -> void:
	Signals.connect("player_damage", Callable(self, "_on_player_damaged"))


# NOTE: This needs to be moved once there are multiple players!
func _on_player_damaged(amount: int) -> void:
	health -= amount
	print("damaged!")
	print(health)

func _check_if_dead() -> void:
	if health <= 0:
		Signals.emit_signal("player_died")
