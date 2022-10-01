extends Control

var selected_item: int

@onready var item_list: ItemList = $HBoxContainer/ItemList
@onready var craft_button: Button = $HBoxContainer/Panel/Button


func _ready() -> void:
	item_list.connect(&"item_selected", _on_selected_item)
	craft_button.connect(&"pressed", _craft_item)
	for i in Util.items:
		item_list.add_item(i.name, i.texture)


func _on_selected_item(index: int) -> void:
	selected_item = index

func _craft_item() -> void:
	pass


