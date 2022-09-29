extends LineEdit


@onready var text_box: VBoxContainer = get_node("../VBoxContainer2")
@onready var chat_client: Node = get_node("../ChatClient")
@onready var chat_server: Node = get_node("../ChatServer")

var chat_message_container := preload("res://ui/hud/chat/chat_message_contianer.tscn")

func _ready() -> void:
	connect("text_submitted", _on_text_submitted)
	Signals.connect("message_sent", _on_message_sent)
	editable = false
	visible = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_chat"):
		if visible:
			return
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
	var msg = _format_text_chat(new_text)
	_send_message(msg)
	clear()


func _send_message(msg: String) -> void:
	var message = chat_message_container.instantiate()
	message.get_node("Panel/Label").text = msg
	text_box.add_child(message)


func _on_message_sent(msg: String) -> void:
	_send_message(msg)


func _format_text_chat(message: String) -> String:
	return "%s: %s" % [Settings.player_name, message]