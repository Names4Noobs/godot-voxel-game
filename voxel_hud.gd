extends Control

var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")

@onready var debug_info: Control = $%MonitorOverlay
@onready var block_label: Label = $Label

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_hud"):
		hide() if visible else show()
	elif Input.is_action_just_pressed("toggle_debug_info"):
		debug_info.hide() if debug_info.visible else debug_info.show()


func _on_voxel_interaction_selected_new_voxel(new_id) -> void:
	block_label.text = voxel_library.get_voxel(new_id).voxel_name
	#block_label.text = "Slot selected: "
	#block_label.text += str(new_id)
