extends Control

var selected_item: int

@onready var item_list: ItemList = $VBoxContainer/ItemList
@onready var craft_button: Button = $VBoxContainer/Button


func _ready() -> void:
	item_list.connect("item_selected", Callable(self, "_on_selected_item"))
	craft_button.connect("pressed", Callable(self, "_craft_item"))
	for i in Util.items:
		item_list.add_item(i.name, i.texture)


func _on_selected_item(index: int) -> void:
	selected_item = index


func _craft_item() -> void:
	if item_list.is_anything_selected():
		var item = Util.items[selected_item]
		print("Crafted %s" % item.name)
		Util.get_player_inventory().add_item_to_empty_slot(item, item.max_stack_size)
