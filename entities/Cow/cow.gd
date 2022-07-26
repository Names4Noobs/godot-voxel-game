extends RigidDynamicBody3D

var health := 100
var is_dead := false

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D


func _ready() -> void:
	anim_player.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))


func interact() -> bool:
	print("You just interacted with a cow!")
	print("WOw!")
	return true


func damage(amount: int) -> void:
	print("You hit a cow with %s damage." % amount)
	health -= amount
	audio.play()
	if health <= 0 and !is_dead:
		$AnimationPlayer.play("die")
		is_dead = true
		Signals.emit_signal("drop_item", Util.beef_item, self.position, 1, true)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		StringName("die"):
			queue_free()
		_:
			print("Cow: The %s animation has just finished!" % anim_name)



