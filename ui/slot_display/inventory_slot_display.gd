extends Control

var slot_data: Resource
var item_tooltip := preload("res://ui/item_tooltip/item_tooltip.tscn")


@export var slot_number = -1

var process_input = false:
	set(v):
		set_process_input(v)
		process_input = v


func _ready() -> void:
	connect("mouse_entered", Callable(
		func(): 
			$SelectionColorRect.visible = true
			process_input = true ))
	connect("mouse_exited", Callable(
		func(): 
			if !Rect2(Vector2(), size).has_point(get_local_mouse_position()):
				$SelectionColorRect.visible = false
				process_input = false ))


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("drop_item"):
		if Rect2(Vector2(), size).has_point(get_local_mouse_position()):
			print(str(self) + "Dropping item")
			Signals.emit_signal("drop_item", Util.dirt_block_item, Vector3.ZERO, 4, false)


func _get_drag_data(_at_position: Vector2):
	var data = {}
	data["swapped_slot"] = slot_number
	
	# Create texture
	var texture := TextureRect.new()
	texture.texture = $TextureRect.texture
	texture.size = Vector2(64,64)
	
	var label = Label.new()
	var label_settings = LabelSettings.new()
	label_settings.font = preload("res://assets/fonts/monocraft/Monocraft.otf")
	label_settings.font_size = 16
	label.text = $Label.text
	label.label_settings = label_settings
	
	# Create control to change texture pos from
	var control := Control.new()
	control.add_child(texture)
	control.add_child(label)
	texture.position = -0.5 * texture.size
	label.position.y += 50
	label.position.x -= 50
	set_drag_preview(control)
	
	return data


func _can_drop_data(_at_position: Vector2, data) -> bool:
	if data.has("swapped_slot"):
		return true
	else:
		printerr(str(self) + "Failed to drop data on this control!")
		return false


func _drop_data(_at_position: Vector2, data) -> void:
	Signals.emit_signal("inventory_swap_slots", slot_number, data["swapped_slot"])


func _make_custom_tooltip(for_text: String) -> Object:
	var tooltip = item_tooltip.instantiate()
	tooltip.get_node("RichTextLabel").text = "[wave]" + for_text + "[/wave]"
	add_child(tooltip)
	return tooltip
