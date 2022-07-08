extends ProgressBar

@export @onready var timer: Timer = $%VoxelInteraction/Timer


func _ready() -> void:
	rounded = false
	min_value = 0
	max_value = timer.wait_time


func _process(delta: float) -> void:
	if Input.is_action_pressed("break"):
		_update_break_progress()
	if !Input.is_action_pressed("break"):
		value = 0
		max_value = timer.wait_time


func _update_break_progress() -> void:
	value = timer.wait_time - timer.time_left
