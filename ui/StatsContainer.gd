extends VBoxContainer


@onready var health_progress := $HBoxContainer/ProgressBar
@onready var stamina_progress := $HBoxContainer2/ProgressBar

func _ready() -> void:
	Signals.connect("player_health_changed", Callable(self, "_on_health_changed"))
	Signals.connect("player_stamina_changed", Callable(self, "_on_stamina_changed"))


func _on_health_changed(value: int) -> void:
	health_progress.value = value


func _on_stamina_changed(value: int) -> void:
	stamina_progress.value = value
