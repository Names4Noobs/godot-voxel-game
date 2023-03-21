class_name ChestEntity
extends StaticBody3D

const NUMBER_OF_SLOTS := 27

var inventory := Inventory.new(NUMBER_OF_SLOTS)
var model_material: StandardMaterial3D

@onready var chest_model := $chest/Node2/chest
@onready var animation_player := $chest/AnimationPlayer


func _ready() -> void:
	model_material = _create_chest_material()
	inventory.add_item_stack(ItemStack.new(Game.get_item("dirt_block"), 999))
	inventory.add_item_stack(ItemStack.new(Game.get_item("grass_block"), 999))
	inventory.add_item_stack(ItemStack.new(Game.get_item("log_block"), 999))
	inventory.add_item_stack(ItemStack.new(Game.get_item("leaf_block"), 999))
	set_chest_texture()


func open() -> void:
	animation_player.play("open")
	var player_menu := Game.get_player_menu()
	if player_menu != null:
		player_menu.open_container(inventory)
	await player_menu.closed
	animation_player.play("close")


func destroy() -> void:
	queue_free()


func set_chest_texture() -> void:
	$chest/Node2/chest/cube.set_material_override(model_material)
	$chest/Node2/chest/cube2.set_material_override(model_material)
	$chest/Node2/chest/cube3.set_material_override(model_material)


func _create_chest_material() -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
	# NOTE: For some reason godot flips textures when importing a gltf.
	# To import a normal texture, the texture needs to be flipped...
	var img := load("res://assets/textures/entity/chest/normal.png")
	img.flip_y()
	material.albedo_texture = ImageTexture.create_from_image(img)
	return material
