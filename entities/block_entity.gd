extends RigidDynamicBody3D


var type = -1

@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var anim_sprite: AnimatedSprite3D = $AnimatedSprite3D


func _ready() -> void:
	audio.connect("finished", Callable(self, "_on_audio_stream_player_3d_finished"))
	anim_sprite.connect("animation_finished", Callable(self, "_on_animated_sprite_3d_animation_finished"))



func interact() -> bool:
	match type:
		Util.BlockEntity.CRAFTING:
			print("This should open some sort of menu!")
		Util.BlockEntity.FURNACE:
			print("This should smelt!")
		Util.BlockEntity.TNT:
			Signals.emit_signal("create_explosion", self.position, 10)
			anim_sprite.visible = true
			anim_sprite.play(&"explode")
			audio.play()
		_:
			print("Block entity type unrecognized!")
	return true


func _on_audio_stream_player_3d_finished() -> void:
	pass


func _on_animated_sprite_3d_animation_finished() -> void:
	queue_free()
