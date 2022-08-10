extends Control

@onready var pointed_voxel_label: Label = $VBoxContainer/Panel/PointedVoxelLabel
@onready var processor_label: Label = $VBoxContainer/Panel2/ProcessorLabel
@onready var video_adapter_label: Label = $VBoxContainer/Panel3/VideoAdapterLabel


func _ready() -> void:
	Signals.connect("selected_block_changed", Callable(self, "_on_pointed_voxel_changed"))
	processor_label.set_text(OS.get_processor_name())
	video_adapter_label.set_text(RenderingServer.get_video_adapter_name())

func _on_pointed_voxel_changed(pos: Vector3i, _data) -> void:
	pointed_voxel_label.text = "Pointed voxel: " + str(pos)
