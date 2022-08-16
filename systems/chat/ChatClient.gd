extends Node

@export var websocket_url = "ws://localhost:9080"

var connected := false
var _client = WebSocketClient.new()

func _ready():
	_client.connect(&"connection_closed", _closed)
	_client.connect(&"connection_error", _closed)
	_client.connect(&"connection_established", _connected)
	_client.connect(&"data_received", _on_data)
	
	connect_to_server()

func connect_to_server() -> void:
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)


func send_message(msg: String) -> void:
	_client.get_peer(1).put_packet(msg.to_utf8_buffer())


func _closed(was_clean: bool = false):
	print("Closed, clean: ", was_clean)
	set_process(false)


func _connected(proto: String = ""):
	print("Connected with protocol: ", proto)
	var string = "%s joined the game" % Settings.player_name
	_client.get_peer(1).put_packet(string.to_utf8_buffer())
	connected = true


func _on_data():
	var string = _client.get_peer(1).get_packet().get_string_from_utf8()
	print("Got data from server: ", string)
	Signals.emit_signal("message_sent", string)


func _physics_process(_delta: float) -> void:
	_client.poll()


func _exit_tree():
	_client.disconnect_from_host()
