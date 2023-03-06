extends Node



@export var inventory: Inventory
@export var head: Node3D


func _input(event: InputEvent) -> void:
	if event.is_action_released("drop_item"):
		var selected_slot = inventory.get_selected_slot()
		if not selected_slot.is_empty():
			var item_drop := Game.ItemDropScene.instantiate()
			item_drop.position = head.global_position + (-head.basis.z.normalized() * 2)
			var new_item_stack := ItemStack.new()
			new_item_stack.item = selected_slot.item
			new_item_stack.amount = 1
			item_drop.item_stack = new_item_stack
			selected_slot.amount -= 1
			get_node("../../../..").add_child(item_drop)
