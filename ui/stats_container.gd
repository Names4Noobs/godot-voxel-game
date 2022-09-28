extends HBoxContainer


@onready var health_progress := $Health/ProgressBar
@onready var stamina_progress := $Stamina/ProgressBar

func _ready() -> void:
	Signals.connect("player_health_changed", _on_health_changed)
	Signals.connect("player_stamina_changed", _on_stamina_changed)
	# This needs to be done in a better way
	Signals.emit_signal("player_health_requested")
	Signals.emit_signal("player_stamina_requested")


func _on_health_changed(value: int) -> void:
	health_progress.value = value


func _on_stamina_changed(value: int) -> void:
	stamina_progress.value = value
