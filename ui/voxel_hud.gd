extends Control


@onready var debug_info: Control = $%MonitorOverlay
@onready var block_label: Label = $Label
@onready var hotbar: HBoxContainer = $Hotbar
@onready var break_progress: ProgressBar = $ProgressBar
@onready var voxel_interaction = $%VoxelInteraction

var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")


func _ready() -> void:
	Signals.connect("changed_selected_slot", Callable(self, "_on_changed_selected_slot"))


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_hud"):
		hide() if visible else show()
	elif Input.is_action_just_pressed("toggle_debug_info"):
		debug_info.hide() if debug_info.visible else debug_info.show()


func _on_changed_selected_slot(slot_data: Resource, _slot_number: int) -> void:
	if slot_data.item != null:
		block_label.text = slot_data.item.display_name


