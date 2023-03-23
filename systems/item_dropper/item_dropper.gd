extends Node


@export var hotbar: Hotbar
@export var head: Node3D


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("drop_stack"):
		var selected_slot = hotbar.get_selected_slot()
		if not selected_slot.is_empty():
			_drop_item(selected_slot.amount)
	elif Input.is_action_just_released("drop_item"):
		_drop_item(1)


func _drop_item(amount: int) -> void:
	var selected_slot = hotbar.get_selected_slot()
	if not selected_slot.is_empty():
		var item_drop := GameWorld.ItemDropScene.instantiate()
		var pos := head.global_position
		pos.y -= 1.5
		item_drop.position = pos + (-head.basis.z.normalized() * 1.5)
		item_drop.velocity.x = -head.basis.z.normalized().x * 4
		item_drop.velocity.z = -head.basis.z.normalized().z * 4
		item_drop.item_stack = ItemStack.new(selected_slot.item, amount)
		selected_slot.amount -= amount
		Game.world.add_child(item_drop)
