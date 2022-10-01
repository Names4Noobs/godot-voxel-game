extends Control

@onready var item_list: ItemList = $HBoxContainer/ItemList
@onready var needed_items_list: ItemList = $HBoxContainer/ItemList2
@onready var craft_button: Button = $HBoxContainer/ItemList2/Button

var items: Array[Resource]

func _ready() -> void:
	item_list.connect(&"item_selected", _on_selected_item)
	craft_button.connect(&"pressed", _craft_item)
	for i in Util.recipes:
		items.append(i)
		item_list.add_item(i.crafted_item.name, i.crafted_item.texture)


func _on_selected_item(index: int) -> void:
	needed_items_list.clear()
	var recipe = Util.recipes[index]
	if recipe.item_1 != null:
		needed_items_list.add_item(recipe.item_1.name + " x" + str(recipe.item_1_quantity), recipe.item_1.texture)
	if recipe.item_2 != null:
		needed_items_list.add_item(recipe.item_2.name + " x" + str(recipe.item_2_quantity), recipe.item_2.texture)


func _craft_item() -> void:
	pass


