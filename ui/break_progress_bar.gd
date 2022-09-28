extends ProgressBar

@export_node_path(Timer) var timer_path 
@onready var timer = get_node(timer_path)

func _ready() -> void:
	rounded = false
	min_value = 0
	max_value = timer.wait_time


func _process(_delta: float) -> void:
	if Input.is_action_pressed("break"):
		_update_break_progress()
	if !Input.is_action_pressed("break"):
		if timer != null:
			value = 0
			max_value = timer.wait_time
			hide()

func _update_break_progress() -> void:
	if timer == null:
		print("timer is null")
		return
	if !timer.is_stopped():
		value = timer.wait_time - timer.time_left
		max_value = timer.wait_time
		show()
