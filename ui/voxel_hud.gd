extends Control


@onready var debug_info: Control = $%MonitorOverlay
@onready var item_label: Label = $Panel/Label
@onready var item_label_panel: Panel = $Panel
@onready var item_label_animation: AnimationPlayer = $Panel/AnimationPlayer
@onready var hotbar: HBoxContainer = $Hotbar
@onready var break_progress: ProgressBar = $ProgressBar
@onready var voxel_interaction := $%VoxelInteraction


func _ready() -> void:
	Signals.connect("changed_selected_slot", Callable(self, "_on_changed_selected_slot"))
	Signals.connect("hide_hud", Callable(self, "_on_hide_hud"))
	Signals.connect("show_hud", Callable(self, "_on_show_hud"))
	item_label_panel.hide()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_hud"):
		hide() if visible else show()
	elif Input.is_action_just_pressed("toggle_debug_info"):
		debug_info.hide() if debug_info.visible else debug_info.show()


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
