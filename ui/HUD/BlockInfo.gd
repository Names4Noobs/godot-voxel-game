extends Panel


@onready var id_label: Label = $VBoxContainer/Label
@onready var hardness_label: Label = $VBoxContainer/Label2
@onready var tool_label: Label = $VBoxContainer/Label3

func _ready() -> void:
	Signals.connect("selected_block_changed", Callable(self, "_on_selected_block_changed"))


func _on_selected_block_changed(_pos, new_block: Resource) -> void:
	if new_block == null:
		return
	if new_block is BlockData:
		id_label.text = "ID: " + str(new_block.voxel_id)
		hardness_label.text = "Hardness: " + str(new_block.hardness)
		tool_label.text = "Tool: " + str(Util.get_tool_type_string(new_block.tool_type))
