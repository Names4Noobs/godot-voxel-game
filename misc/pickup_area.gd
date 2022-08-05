extends Area3D


@export_node_path(Node) var inventory_path
@onready var inventory := $%Inventory

func _ready() -> void:
	collision_layer = 1
	collision_mask = 3

func _on_pickup_area_body_entered(body: Node3D) -> void:
	if body is ItemDropEntity:
		if body.item != null:
			#print("Picked up x" + str(body.item_count) + " " + body.item.display_name)
			if inventory.inventory != null:
				inventory.inventory.add_item_to_stack(body.item, body.item_count)
		body.queue_free()
