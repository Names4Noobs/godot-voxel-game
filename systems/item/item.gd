extends Node
class_name Item
@icon("res://assets/beef.png")

@export var display_name := "Default Item"
@export var texture: Texture2D = preload("res://assets/dirt.png")

#
#func _init(p_name: String = display_name, p_texture = texture) -> void:
#	display_name = p_name
#	texture = p_texture


func primary_action() -> void:
	print("Item primary action used!")


func secondary_action() -> void:
	print("Item secondary action used!")
