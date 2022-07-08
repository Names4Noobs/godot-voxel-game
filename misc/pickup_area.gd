extends Area3D


func _on_pickup_area_body_entered(body: Node3D) -> void:
	if body is ItemDropEntity:
		body.queue_free()
