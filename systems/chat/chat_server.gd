extends Node

# Sent from Client to Server
enum ClientToServer {Ping=1, Login=2, ChatMessage=3}
enum ServerToClient {JoinedServer=1, MessageServer=2}

const PORT := 9080

var _server := WebSocketServer.new()

var users: Array[int] = []
var chat_log: Array[String] = []


func _ready() -> void:
	_server.client_connected.connect(_on_client_connected)
	_server.client_disconnected.connect(_on_client_disconnected)
	_server.client_close_request.connect(_on_client_close_request)
	_server.data_received.connect(_on_data_recieved)
	_server.bind_ip = "127.0.0.1"

func _process(_delta: float) -> void:
	_server.poll()

func _exit_tree() -> void:
	print("Server: stopping")
	_server.stop()


func start_server() -> void:
	var err = _server.listen(PORT)
	if err == OK:
		print("Server: listening on port %d" % PORT)
	if err != OK:
		print("Unable to start server")
		printerr(err)
		set_process(false)


func _on_client_connected(id: int, protocol: String, _resource_name: String) -> void:
	print("Client %d connected with protocol: %s" % [id, protocol])
	users.append(id)


func _on_client_disconnected(id: int, was_clean_close: bool) -> void:
	print("Client %d disconnected, clean: %s" % [id, str(was_clean_close)])


func _on_client_close_request(id: int, code: int, reason: String) -> void:
	print("Client %d disconnecting with code: %d, reason: %s" % [id, code, reason])


func _on_data_recieved(id: int) -> void:
	var pkt = _server.get_peer(id).get_packet()
	var pkt_id = pkt.decode_u8(0)
	match pkt_id:
		ClientToServer.Ping:
			# TODO: Send basic info about server like num of ppl connected
			pass
		ClientToServer.Login:
			# TODO: Send packet about other users info
			# https://wiki.vg/Server_List_Ping
			pass
		ClientToServer.ChatMessage:
			var utf8_slice = pkt.slice(1)
			var msg = utf8_slice.get_string_from_utf8()
			send_message(id, msg)
		0:
			print("Failed to decode packet id. Decode_u8 returned 0.")
		_:
			print("Server: unknown packet id: %d" % pkt_id)


func send_message(id: int, msg: String) -> void:
	print("Got message from client %d: %s ... echoing" % [id, msg])
	var new_msg = "%d: %s" % [id, msg]
	for user in users:
		_server.get_peer(user).put_packet(new_msg.to_utf8_buffer())
	chat_log.append(new_msg)
