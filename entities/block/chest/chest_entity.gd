class_name ChestEntity
extends StaticBody3D

const NUMBER_OF_SLOTS := 27

var inventory_id := 1
var slots: Array[ItemStack] = []
var model_material: StandardMaterial3D

@onready var chest_model := $chest/Node2/chest
@onready var animation_player := $chest/AnimationPlayer


func _ready() -> void:
	model_material = _create_chest_material()
	_generate_slots()
	set_chest_texture()


func open() -> void:
	animation_player.play("open")
	var player_menu := Game.get_player_menu()
	if player_menu != null:
		Game.get_player_menu().open_container(inventory_id)
	await get_tree().create_timer(0.5).timeout
	animation_player.play("close")


func destroy() -> void:
	queue_free()

func _generate_slots() -> void:
	for i in range(NUMBER_OF_SLOTS):
		slots.append(ItemStack.new(Game.get_item("dirt_block"), 4))
	Game.register_inventory(inventory_id, slots)


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
