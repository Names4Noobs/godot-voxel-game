extends Control

@onready var item_list: ItemList = $ItemList


func _ready() -> void:
	for item in Util.items:
		item_list.add_item(item.name, item.texture)
	item_list.connect(&"item_activated", _give_item)

func _give_item(index: int) -> void:
	var item = Util.items[index]
	print("Given x%d %s" % [item.max_stack_size, item.name])
	Util.get_player_inventory().add_item_to_empty_slot(item, item.max_stack_size)
