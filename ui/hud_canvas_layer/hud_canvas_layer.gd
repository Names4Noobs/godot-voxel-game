extends CanvasLayer

var hud_disabled := false

func _ready() -> void:
	Events.connect("player_menu_opened", func(): hide())
	Events.connect("player_menu_closed", func(): show())


func _on_player_spawned(spawned_player: Player) -> void:
	var camera_switcher := spawned_player.get_camera_switcher()
	if camera_switcher != null:
		camera_switcher.connect("freecam_toggled", _on_freecam_toggled)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_hud"):
		if hud_disabled:
			return
		hide() if visible else show()


func _on_freecam_toggled(enabled: bool) -> void:
	if enabled and visible:
		hide()
	elif !enabled and !visible:
		show()
	hud_disabled = enabled
