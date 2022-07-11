extends Control

var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")

@onready var debug_info: Control = $%MonitorOverlay
@onready var block_label: Label = $Label
@onready var hotbar: HBoxContainer = $Hotbar
@onready var break_progress: ProgressBar = $ProgressBar
@onready var voxel_interaction = $%VoxelInteraction


func _ready() -> void:
	Signals.connect("changed_selected_slot", Callable(self, "_on_changed_selected_slot"))
	voxel_interaction.connect("placed_voxel", Callable(self, "_on_voxel_interaction_placed_voxel"))
	voxel_interaction.connect("broke_voxel", Callable(self, "_on_voxel_interaction_broke_voxel"))


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_hud"):
		hide() if visible else show()
	elif Input.is_action_just_pressed("toggle_debug_info"):
		debug_info.hide() if debug_info.visible else debug_info.show()


func _on_changed_selected_slot(new_slot: int) -> void:
	block_label.text = str(new_slot)
	hotbar.selected_slot = new_slot


func _on_voxel_interaction_broke_voxel(_pos, v_name) -> void:
	print("Broke " + str(v_name))


func _on_voxel_interaction_placed_voxel(_pos, v_name) -> void:
	print("Placed " + str(v_name))

