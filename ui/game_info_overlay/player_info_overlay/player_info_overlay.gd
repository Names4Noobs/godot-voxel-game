extends VBoxContainer

var player: Player

@onready var position_label := $Position
@onready var block_position_label := $BlockPosition
@onready var velocity_label := $Velocity
@onready var direction_label := $Direction


func _ready() -> void:
	Events.connect("player_spawned", func(v): player = v)


func _physics_process(_delta: float) -> void:
	if not visible or not player:
		return
	position_label.set_text("XYZ: " + str(player.position))
	block_position_label.set_text("Block: " + str(_get_player_block()))
	direction_label.set_text("Facing: " + str(player.get_camera_head().rotation_degrees))
	velocity_label.set_text("Velocity: "  + str(player.velocity))


func _get_player_block() -> Vector3i:
	var result = player.voxel_interactor.get_voxel_below()
	if result:
		return result.previous_position
	return Vector3i.ZERO
