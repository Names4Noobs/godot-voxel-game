class_name ItemDrop
extends CharacterBody3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var item_stack: ItemStack:
	set(v):
		item_stack = v
		await self.ready
		_update_item_visual()

var merging := false

@onready var pickup_area := $PickupArea
@onready var merge_area := $MergeArea
@onready var block_renderer := $BlockRenderer
@onready var sprite := $Sprite3D


func _ready() -> void:
	pickup_area.connect("body_entered", _on_pickup_body_entered)
	block_renderer.hide()
	sprite.hide()


func _physics_process(delta: float) -> void:
	rotate_y(0.01)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if is_on_floor():
		velocity.x = 0
		velocity.z = 0
		#try_merge()
	move_and_slide()


func destroy() -> void:
	# NOTE: I need to manually free materials in the block renderer for some reason
	block_renderer.delete()
	queue_free()


func _on_pickup_body_entered(body: Node3D) -> void:
	if item_stack == null:
		return
	if body is Player:
		if body.has_method("get_inventory"):
			body.get_inventory().add_item_stack(item_stack)
			destroy()

# This is very scuffed......
func try_merge() -> void:
	for body in merge_area.get_overlapping_bodies():
		if body == self:
			return
		if body is ItemDrop and body.item_stack != null:
			if body.merging == true:
				return
			if !body.item_stack.is_empty() and !item_stack.is_empty():
				if body.is_on_floor():
					if body.item_stack.item == item_stack.item: 
						body.merge(self)


func merge(new_drop: ItemDrop) -> void:
	merging = true
	hide()
	new_drop.item_stack.amount += item_stack.amount
	destroy()


func _update_item_visual() -> void:
	if block_renderer == null:
		return
	if item_stack != null and item_stack.item != null:
		var item := item_stack.item
		if item is BlockItem:
			block_renderer.show()
			block_renderer.set_block_textures(Game.get_block(item_stack.item.block_id))
		elif item is Item:
			sprite.show()
			sprite.texture = item_stack.item.texture
