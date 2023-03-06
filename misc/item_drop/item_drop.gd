class_name ItemDrop
extends CharacterBody3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var item_stack: ItemStack:
	set(v):
		item_stack = v
		_update_block_visual()

@onready var pickup_area := $Area3D


func _ready() -> void:
	pickup_area.connect("body_entered", _on_pickup_body_entered)


func _physics_process(delta: float) -> void:
	rotate_y(0.01)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if is_on_floor():
		velocity.x = 0
		velocity.z = 0
	move_and_slide()


func destroy() -> void:
	queue_free()

func _on_pickup_body_entered(body: Node3D) -> void:
	if item_stack == null:
		return
	if body is Player:
		if body.has_method("get_inventory"):
			body.get_inventory().add_item_stack(item_stack)
			destroy()


func _update_block_visual() -> void:
	if item_stack != null and item_stack.item != null:
		if item_stack.item.texture != null:
			$CSGBox3D.material.albedo_texture = item_stack.item.texture
