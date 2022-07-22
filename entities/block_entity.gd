extends RigidDynamicBody3D

var type = -1

@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _ready() -> void:
	audio.connect("finished", Callable(self, "_on_audio_stream_player_3d_finished"))



func interact() -> bool:
	match type:
		Util.BlockEntity.CRAFTING:
			print("This should open some sort of menu!")
		Util.BlockEntity.FURNACE:
			print("This should smelt!")
		Util.BlockEntity.TNT:
			Signals.emit_signal("create_explosion", self.position, 10)
			audio.play()
		_:
			print("Block entity type unrecognized!")
	return true


func _on_audio_stream_player_3d_finished() -> void:
	queue_free()
