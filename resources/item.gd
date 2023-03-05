class_name Item
extends Resource

var item_id: StringName
var name: StringName
var texture: Texture2D


func _init(p_id: StringName) -> void:
	item_id = p_id
