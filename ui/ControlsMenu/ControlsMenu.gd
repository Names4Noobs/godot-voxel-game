extends Control

var action := preload("res://ui/ControlsMenu/Action/Action.tscn")

@onready var vbox = $ScrollContainer/VBoxContainer

func _ready() -> void:
	for i in InputMap.get_actions():
		var string: String = i
		if str(i).begins_with("ui_"):
			continue
		else:
			var action_node = action.instantiate()
			var action_string = ""
			for event in InputMap.action_get_events(i):
				action_string += event.as_text() 
			action_node.get_node("Label").text = string.capitalize()
			action_node.get_node("Button").text = action_string
			vbox.add_child(action_node)
