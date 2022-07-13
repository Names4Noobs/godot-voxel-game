extends Resource
class_name InventorySlot

@export var item: Resource = ItemData.new()
@export var quantity: int = 1

func _init(p_item: Resource = item, p_quanitiy: int = quantity) -> void:
	item = p_item 
	quantity = p_quanitiy

func get_item() -> Resource:
	return item
