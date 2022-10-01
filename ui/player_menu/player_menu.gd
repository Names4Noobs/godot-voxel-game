extends Control

#enum Tabs {STATS, INVENTORY, CRAFTING}

@onready var tab_container: TabContainer = $TabContainer


func _ready() -> void:
	Signals.emit_signal(&"hide_hud")
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	tab_container.current_tab = 0


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"open_inventory"):
		close_menu()
		get_viewport().set_input_as_handled()
	elif Input.is_action_just_pressed(&"ui_cancel"):
		close_menu()
		get_viewport().set_input_as_handled()


func close_menu() -> void:
	Signals.emit_signal(&"show_hud")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	queue_free()
