extends Node

const ItemDropScene := preload("res://misc/item_drop/item_drop.tscn")

signal block_placed

var blocks: Dictionary
var items: Dictionary
var player_inventory: Inventory
var world: Node3D


func _ready() -> void:
	_generate_blocks()
	_generate_items()
	world = get_node_or_null("/root/World")


func register_block(block: Block) -> void:
	blocks.merge({block.block_id: block})


func register_item(item: Item) -> void:
	items.merge({item.item_id: item})


func create_item_drop(position: Vector3, item_id: String, amount: int) -> void:
	var drop := ItemDropScene.instantiate()
	drop.position = position
	drop.item_stack = ItemStack.new(get_item(item_id), amount)
	world.add_child(drop)


func get_block(block_id: StringName) -> Block:
	if blocks.has(block_id):
		return blocks[block_id]
	return null


func get_item(item_id: StringName) -> Item:
	if items.has(item_id):
		return items[item_id]
	return null


func _generate_blocks() -> void:
	var air_block := Block.new("air")
	air_block.voxel_id = 0
	air_block.name = "Air"
	air_block.geometry_type = VoxelBlockyModel.GEOMETRY_NONE
	register_block(air_block)
	
	var grass_block := Block.new("grass")
	grass_block.voxel_id = 1
	grass_block.name = "Grass"
	grass_block.color = Color.GREEN
	var top_grass_texture := load("res://assets/textures/block/grass_block_top_altered.png")
	var side_grass_texture := load("res://assets/textures/block/grass_block_side.png")
	grass_block.set_two_textures(top_grass_texture, side_grass_texture)
	register_block(grass_block)

	var dirt_block := Block.new("dirt")
	dirt_block.voxel_id = 2
	dirt_block.name = "Dirt"
	dirt_block.set_single_texture(load("res://assets/textures/block/dirt.png"))
	dirt_block.color = Color.SADDLE_BROWN
	register_block(dirt_block)

	var stone_block := Block.new("stone")
	stone_block.voxel_id = 3
	stone_block.name = "Stone"
	stone_block.set_single_texture(load("res://assets/textures/block/stone.png"))
	register_block(stone_block)

	var log_block := Block.new("log")
	log_block.voxel_id = 4
	log_block.name = "Log"
	var top_log_texture := load("res://assets/textures/block/oak_log_top.png")
	var side_log_texture := load("res://assets/textures/block/oak_log.png")
	log_block.set_two_textures(top_log_texture, side_log_texture)
	register_block(log_block)

	var leaf_block := Block.new("leaf")
	leaf_block.voxel_id = 5
	leaf_block.name = "Leaf"
	leaf_block.set_single_texture(load("res://assets/textures/item/leaf.png"))
	register_block(leaf_block)


func _generate_items() -> void:
	var grass_block_item := BlockItem.new("grass_block")
	grass_block_item.block_id = "grass"
	grass_block_item.name = "Grass Block"
	grass_block_item.texture = load("res://assets/textures/item/grass.png")
	register_item(grass_block_item)
	
	var dirt_block_item := BlockItem.new("dirt_block")
	dirt_block_item.block_id = "dirt"
	dirt_block_item.name = "Dirt Block"
	dirt_block_item.texture = load("res://assets/textures/item/dirt.png")
	register_item(dirt_block_item)

	var stone_block_item := BlockItem.new("stone_block")
	stone_block_item.block_id = "stone"
	stone_block_item.name = "Stone Block"
	stone_block_item.texture = load("res://assets/textures/item/stone.png")
	register_item(stone_block_item)

	var log_block_item := BlockItem.new("log_block")
	log_block_item.block_id = "log"
	log_block_item.name = "Log Block"
	log_block_item.texture = load("res://assets/textures/item/log.png")
	register_item(log_block_item)

	var leaf_block_item := BlockItem.new("leaf_block")
	leaf_block_item.block_id = "leaf"
	leaf_block_item.name = "Leaf Block"
	leaf_block_item.texture = load("res://assets/textures/item/leaf.png")
	register_item(leaf_block_item)


# Apparently you can not set cube tiles in a script.....
func _generate_voxel_library() -> void:
	var library := VoxelBlockyLibrary.new()
	library.voxel_count = blocks.size()
	for block in blocks:
		var block_data: Block = blocks[block]
		var voxel := library.create_voxel(block_data.voxel_id, block_data.name)
		if block_data.geometry_type != null:
			voxel.geometry_type = block_data.geometry_type
		if block_data.color != null:
			voxel.color = block_data.color
		if block_data.random_tickable != null:
			voxel.random_tickable = block_data.random_tickable
	ResourceSaver.save(library, "res://data/voxel_terrain/voxel_library.tres")
