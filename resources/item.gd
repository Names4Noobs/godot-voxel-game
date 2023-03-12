class_name Item
extends Resource

var item_id: StringName
var name: StringName
var texture: Texture2D
var stack_size := 64


func _init(p_id: StringName) -> void:
	item_id = p_id


func set_item_texture() -> void:
	texture = load("res://assets/textures/item/%s.png" % item_id)
