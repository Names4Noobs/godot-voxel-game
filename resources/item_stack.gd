class_name ItemStack
extends Resource

signal item_changed(new_item: Item)
signal amount_changed(new_amount: int)


var item: Item:
	set(v):
		item = v
		emit_signal("item_changed", item)
var amount := 0:
	set(v):
		amount = v
		emit_signal("amount_changed", amount)
		if amount <= 0:
			item = null
# This contains arbitrary metadata about an item stack
# Values that can be used:
# "name_override"
# "color"
var metadata := {}


func _init(p_item: Item = null, p_amount: int = 0) -> void:
	item = p_item
	amount = p_amount
	resource_local_to_scene = true


static func create_full_stack(item_id: String) -> ItemStack:
	var result := Game.get_item(item_id)
	if result == null:
		return
	return ItemStack.new(result, result.stack_size)

func copy(item_stack: ItemStack) -> void:
	item = item_stack.item
	amount = item_stack.amount 

func is_empty() -> bool:
	if item == null:
		return true
	return false

func add_metadata(key: StringName, value: Variant) -> void:
	metadata.merge({key:value})

func remove_metadata(key: StringName) -> void:
	if has_metadata(key):
		metadata.erase(key)

func has_metadata(key: StringName) -> bool:
	if metadata.has(key):
		return true
	else:
		return false
