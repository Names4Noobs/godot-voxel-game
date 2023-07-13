extends Node


@export var hotbar: Hotbar
@export var head: Node3D


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("drop_stack"):
		var selected_slot = hotbar.get_selected_slot()
		if not selected_slot.is_empty():
			drop_item(selected_slot, selected_slot.amount)
	elif Input.is_action_just_released("drop_item"):
		var selected_slot = hotbar.get_selected_slot()
		if not selected_slot.is_empty():
			drop_item(selected_slot, 1)


func drop_item(slot: ItemStack, amount: int) -> void:
	if not slot.is_empty():
		var item_drop := GameWorld.ItemDropScene.instantiate()
		var pos := head.global_position
		pos.y -= 1.5
		item_drop.position = pos + (-head.basis.z.normalized() * 1.5)
		item_drop.velocity.x = -head.basis.z.normalized().x * 4
		item_drop.velocity.z = -head.basis.z.normalized().z * 4
		item_drop.item_stack = ItemStack.new(slot.item, amount)
		slot.amount -= amount
		Game.world.add_child(item_drop)
