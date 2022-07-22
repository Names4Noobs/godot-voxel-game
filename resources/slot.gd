extends Resource
class_name InventorySlot


@export var item: Resource = null
@export var quantity: int = 1:
	set(v):
		if v < 0:
			is_empty = true
			quantity = 0
			return
		quantity = v
@export var is_empty = false


func _init(p_item: Resource = item, p_quanitiy: int = quantity) -> void:
	item = p_item
	if item == null:
		is_empty = true
		return
	quantity = p_quanitiy


func get_item() -> Resource:
	return item


# TODO: Pass in an item id instead of the whole resource
func has_item(item_data: Resource) -> bool:
	if !is_empty:
		# TODO: Create an id for items and create an equals method for item_data
		if item.display_name == item_data.display_name:
			return true
	return false
