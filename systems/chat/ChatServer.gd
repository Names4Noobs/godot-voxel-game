extends Node

# The port we will listen to.
const PORT = 9080
# Our WebSocketServer instance.
var _server = WebSocketServer.new()

var clients: Array[int]


func _ready():
	# Connect base signals to get notified of new client connections,
	# disconnections, and disconnect requests.
	_server.connect(&"client_connected", _connected)
	_server.connect(&"client_disconnected", _disconnected)
	_server.connect(&"client_close_request", _close_request)
	# This signal is emitted when not using the Multiplayer API every time a
	# full packet is received.
	# Alternatively, you could check get_peer(PEER_ID).get_available_packets()
	# in a loop for each connected peer.
	_server.connect(&"data_received", _on_data)
	# Start listening on the given port.

func start_server() -> void:
	var err = _server.listen(PORT)
	if err != OK:
		print("Unable to start server")
		set_process(false)
		print(err)

func _connected(id: int, proto: String, rname: String) -> void:
	# This is called when a new peer connects, "id" will be the assigned peer id,
	# "proto" will be the selected WebSocket sub-protocol (which is optional)
	print("Client %d connected with protocol %s and resource name %s" % [id, proto, rname])
	clients.append(id)
	print(clients)


func _close_request(id:int, code: int, reason: String) -> void:
	# This is called when a client notifies that it wishes to close the connection,
	# providing a reason string and close code.
	print("Client %d disconnecting with code: %d, reason: %s" % [id, code, reason])


func _disconnected(id: int, was_clean: bool = false) -> void:
	# This is called when a client disconnects, "id" will be the one of the
	# disconnecting client, "was_clean" will tell you if the disconnection
	# was correctly notified by the remote peer before closing the socket.
	print("Client %d disconnected, clean: %s" % [id, str(was_clean)])


func _on_data(id: int) -> void:
	# Print the received packet, you MUST always use get_peer(id).get_packet to receive data,
	# and not get_packet directly when not using the MultiplayerAPI.
	var pkt = _server.get_peer(id).get_packet()
	print("Got data from client %d: %s ... echoing" % [id, pkt.get_string_from_utf8()])
	if clients != null:
		for id in clients:
			_server.get_peer(id).put_packet(pkt)


func _physics_process(_delta: float) -> void:
	_server.poll()


func _exit_tree() -> void:
	_server.stop()
