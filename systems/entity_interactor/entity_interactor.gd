extends Node

const PLAYER_ATTACK_DAMAGE := 2.0

@onready var player_camera: Camera3D = get_parent() 


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("primary_action"):
		var entity := _get_pointed_entity()
		if entity != null:
			if entity.has_method("damage"):
				entity.damage(PLAYER_ATTACK_DAMAGE)
			get_viewport().set_input_as_handled()



func _get_pointed_entity() -> CharacterBody3D:
	var ray_length = 16
	var center_screen = _get_viewport_center()
	var origin = player_camera.project_ray_origin(center_screen)
	var target = origin + player_camera.project_ray_normal(center_screen) * ray_length
	var space_state: PhysicsDirectSpaceState3D = get_viewport().find_world_3d().get_direct_space_state()
	var query := PhysicsRayQueryParameters3D.new()
	query.from = origin
	query.to = target
	var result = space_state.intersect_ray(query)
	if result.has("position") and result.has("collider"):
		if result.get("collider") is CharacterBody3D:
			if result.get("collider") is ItemDrop:
				return
			return result.get("collider")
	return null


func _get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport().global_canvas_transform
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport().get_visible_rect().size / scale / 2
