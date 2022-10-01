extends Control


func _ready() -> void:
	self.size = Vector2(32, 32)
	await get_tree().create_timer(1.0).timeout
	queue_free()

