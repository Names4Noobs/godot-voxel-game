extends Resource
class_name PlayerStats

const DEFAULT_HEALTH := 100
const DEFAULT_STAMINA := 100



# Player stats
@export var health := 100:
	set(v):
		health = clampi(v, 0, 100)
		Signals.emit_signal("player_health_changed", health)
		_check_if_dead()
@export var hunger := 100
@export var stamina := 5.0:
	set(v):
		stamina = clampi(v, 0, 100)
		Signals.emit_signal("player_stamina_changed", stamina)


func _init(p_health=DEFAULT_HEALTH, p_stamina=DEFAULT_STAMINA) -> void:
	health = p_health
	stamina = p_stamina
	Signals.connect("player_damage", Callable(self, "_on_player_damaged"))
	


# NOTE: This needs to be moved once there are multiple players!
func _on_player_damaged(amount: int) -> void:
	health -= amount
	print("damaged!")
	print(health)


func _check_if_dead() -> void:
	if health <= 0:
		Signals.emit_signal("player_died")
