extends Control

var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")

@onready var debug_info: Control = $%MonitorOverlay
@onready var block_label: Label = $Label
@onready var hotbar: HBoxContainer = $Hotbar
@onready var break_progress: ProgressBar = $ProgressBar
@onready var voxel_interaction = $%VoxelInteraction


func _ready() -> void:
	Signals.connect("changed_selected_slot", Callable(self, "_on_changed_selected_slot"))


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_hud"):
		hide() if visible else show()
	elif Input.is_action_just_pressed("toggle_debug_info"):
		debug_info.hide() if debug_info.visible else debug_info.show()


func _on_changed_selected_slot(new_slot: int) -> void:
	block_label.text = str(new_slot)


