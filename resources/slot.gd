extends Resource
class_name InventorySlot


@export var item: Resource = ItemData.new()
@export var quantity: int = 1:
	set(v):
		if v < 0:
			# Should I just make an empty item item
			item = null
			quantity = 0
			return
		quantity = v


func _init(p_item: Resource = item, p_quanitiy: int = quantity) -> void:
	item = p_item 
	quantity = p_quanitiy


func get_item() -> Resource:
	return item


func is_empty() -> bool:
	if item == null:
		return true
	return false