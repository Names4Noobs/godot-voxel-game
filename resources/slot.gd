class_name Slot
extends Resource

var item: Item
var amount := 0
var modifiers


func is_empty() -> bool:
	if item == null:
		return true
	else:
		return false
