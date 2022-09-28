extends Node

@export var websocket_url = "ws://127.0.0.1:9080"

var _client := WebSocketClient.new()


func _ready() -> void:
	_client.connection_closed.connect(_closed)
	_client.connection_error.connect(_error)
	_client.connection_established.connect(_connected)
	_client.data_received.connect(_on_data_received)
	_client.server_close_request.connect(_close_request)


func _process(_delta: float) -> void:
	if _client.get_connection_status() == WebSocketClient.CONNECTION_DISCONNECTED:
		return
	_client.poll()


func _exit_tree():
	_client.disconnect_from_host(1001, "Bye bye!")


func connect_to_server() -> void:
	print("Client: connecting to %s" % websocket_url)
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print(err)
		print("Client: Unable to connect")
		set_process(false)


func send_message_to_server(message: String) -> void:
	var packet := PackedByteArray()
	packet.resize(1)
	packet.encode_u8(0,1)
	packet.append_array(message.to_utf8_buffer())
	_client.get_peer(1).put_packet(packet)




func _on_data_received() -> void:
	var pkt = _client.get_peer(1).get_packet().get_string_from_utf8()
	print("Client: Got data from server: ", pkt)
	var label = RichTextLabel.new()
	label.bbcode_enabled = true
	label.fit_content_height = true
	label.text = pkt
	#$%ChatLog.add_child(label)


func _connected(protocol: String) -> void:
	print("Client: connected with protocol: %s" % protocol)
	var packet := PackedByteArray()
	packet.resize(1)
	packet.encode_u8(0,1)
	packet.append_array("Ping!".to_utf8_buffer())
	_client.get_peer(1).put_packet(packet)


func _close_request(code: int, reason: String) -> void:
	print("Client: Server sent close request. Code: %d. Reason: %s." % [code , reason])


func _closed(was_clean: bool) -> void:
	print("Client: Closed, clean: ", was_clean)
	set_process(false)


func _error() -> void:
	print("Client: Connection error")
