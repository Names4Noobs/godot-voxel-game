extends Control

var enabled = false

func _ready() -> void:
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

#func open() -> void:
#	enabled = !enabled
#	if enabled == true:
#		set_process_input(true)
#		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
#		get_tree().paused = true
#		show()
#	else:
#		if Input.is_action_just_pressed("open_inventory"):
#			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
#			get_tree().paused = false
#			hide()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		get_tree().paused = false
		queue_free()
