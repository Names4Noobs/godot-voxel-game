extends Resource
class_name InventorySlot


@export var id := -1
@export var item: Resource = null
@export var quantity: int = 1:
	set(v):
		if v <= 0:
			is_empty = true
			quantity = 0
			return
		quantity = v
@export var is_empty = false


func _init(p_id: int, p_item: Resource = item, p_quanitiy: int = quantity) -> void:
	id = p_id
	item = p_item
	quantity = p_quanitiy
	if item == null:
		is_empty = true
		return
	else:
		quantity = item.max_stack_size



# TODO: Pass in an item id instead of the whole resource
func has_item(item_data: ItemData) -> bool:
	if !is_empty:
		# TODO: Create an id for items and create an equals method for item_data
		if item.name == item_data.name:
			return true
	return false
