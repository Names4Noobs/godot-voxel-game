extends Area3D


func _ready() -> void:
	connect("body_entered", Callable(self, "_on_area_3d_body_entered"))


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method(&"does_damage"):
		get_parent().damage(50)

