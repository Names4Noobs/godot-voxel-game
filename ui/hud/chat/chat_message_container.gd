extends HBoxContainer

@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	anim_player.current_animation = ""
	anim_player.play("fade_out")


func _on_animation_finished(_anim_name: StringName) -> void:
	queue_free()
