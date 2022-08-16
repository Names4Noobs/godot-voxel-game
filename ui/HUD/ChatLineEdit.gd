extends LineEdit


@onready var text_box: VBoxContainer = get_node("../VBoxContainer2")
var chat_message_container := preload("res://ui/Chat/ChatMessageContainer.tscn")

func _ready() -> void:
	connect("text_submitted", Callable(self, "_on_text_submitted"))
	editable = false
	visible = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_chat"):
		if !text.is_empty():
			return
		visible = !visible
		editable = !editable
		get_tree().paused = !get_tree().paused
		if visible:
			grab_focus()
		get_viewport().set_input_as_handled()
	elif Input.is_action_just_pressed("ui_cancel"):
		if visible:
			clear()
			visible = false
			editable = false
			get_tree().paused = false
			get_viewport().set_input_as_handled()


func _on_text_submitted(new_text: String) -> void:
	if new_text == "":
		return
	var message = chat_message_container.instantiate()
	message.get_node("Label").text = _format_text_chat(new_text)
	text_box.add_child(message)
	self.clear()


func _format_text_chat(message: String) -> String:
	return "%s: %s" % [Settings.player_name, message]
