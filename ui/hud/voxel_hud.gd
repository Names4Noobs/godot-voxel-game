extends Control


@onready var item_label: Label = $Panel/Label
@onready var item_label_panel: Panel = $Panel
@onready var item_label_animation: AnimationPlayer = $Panel/AnimationPlayer
@onready var hotbar: HBoxContainer = $VBoxContainer/Hotbar
@onready var break_progress: ProgressBar = $ProgressBar


func _ready() -> void:
	Signals.connect("changed_selected_slot", _on_changed_selected_slot)
	Signals.connect("hide_hud", _on_hide_hud)
	Signals.connect("show_hud", _on_show_hud)
	item_label_panel.hide()
	#_test_notification()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_hud"):
		if visible:
			hide()
		else:
			show()
	# TODO: Recreate debug info panel
#	elif Input.is_action_just_pressed("toggle_debug_info"):
#		if debug_overlay.visible:
#			debug_overlay.hide()  
#		else:
#			debug_overlay.show()

func _test_notification() -> void:
	$NotificationPanel/AnimationPlayer.play("fade_in")
	await get_tree().create_timer(2.5).timeout
	$NotificationPanel/AnimationPlayer.play("fade_out")



func _on_changed_selected_slot(slot_data: Resource, _slot_number: int) -> void:
	if slot_data.is_empty:
		return
	item_label_panel.show()
	if slot_data.item != null:
		item_label.text = slot_data.item.display_name
	if item_label_animation.is_playing():
		item_label_animation.stop()
	item_label_animation.play("fade_out")


func _on_hide_hud() -> void:
	hide()


func _on_show_hud() -> void:
	show()
