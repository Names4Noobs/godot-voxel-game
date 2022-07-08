extends Node
class_name Item

@export var display_name := "Default Item"
@export var texture := load("res://assets/dirt.png")


func primary_action() -> void:
	print("Item primary action used!")


func secondary_action() -> void:
	print("Item secondary action used!")
