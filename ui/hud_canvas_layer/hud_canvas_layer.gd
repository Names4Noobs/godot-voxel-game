extends CanvasLayer

var hud_disabled := false

func _ready() -> void:
	# TODO: Create an event singleton because this code is a mess
	var camera_switcher := Game.get_player().get_node_or_null("CameraSwitcher")
	if camera_switcher != null:
		camera_switcher.connect("freecam_toggled", _on_freecam_toggled)
	var player_menu := get_node_or_null("/root/World/MenuCanvasLayer/PlayerMenu")
	if player_menu != null:
		player_menu.connect("opened", _on_menu_opened)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_hud"):
		if hud_disabled:
			return
		hide() if visible else show()


func _on_menu_opened(opened: bool) -> void:
	hide() if opened else show()


func _on_freecam_toggled(enabled: bool) -> void:
	if enabled and visible:
		hide()
	elif !enabled and !visible:
		show()
	hud_disabled = enabled
