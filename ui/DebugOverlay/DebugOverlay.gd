extends Control

@onready var processor_label = $VBoxContainer/Panel2/ProcessorLabel
@onready var video_adapter_label = $VBoxContainer/Panel3/VideoAdapterLabel


func _ready() -> void:
	processor_label.set_text(OS.get_processor_name())
	video_adapter_label.set_text(RenderingServer.get_video_adapter_name())
