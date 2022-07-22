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
@export var stamina := 100:
	set(v):
		stamina = clampi(v, 0, 100)
		_check_if_can_sprint(stamina)
		Signals.emit_signal("player_stamina_changed", stamina)
@export var defense := 100
@export var strength := 100
@export var speed := 100

@export var can_sprint = true:
	set(v):
		if v != true:
			_start_stamina_regen()

func _init(p_health=DEFAULT_HEALTH, p_stamina=DEFAULT_STAMINA) -> void:
	health = p_health
	stamina = p_stamina
	Signals.connect("player_damage", Callable(self, "_on_player_damaged"))
	Signals.connect("player_health_requested", Callable(self, "_on_health_requested"))
	Signals.connect("player_stamina_requested", Callable(self, "_on_stamina_requested"))
	


# NOTE: This needs to be moved once there are multiple players!
func _on_player_damaged(amount: int) -> void:
	health -= amount


func _on_health_requested() -> void:
	Signals.emit_signal("player_health_changed", health)


func _on_stamina_requested() -> void:
	Signals.emit_signal("player_stamina_changed", stamina)


func _check_if_dead() -> void:
	if health <= 0:
		Signals.emit_signal("player_died")


func _check_if_can_sprint(v: int) -> void:
	if v <= 0:
		can_sprint = false

# Yes, I know this is terrible
func _start_stamina_regen() -> void:
	Signals.emit_signal("player_out_of_stamina")
