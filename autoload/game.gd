extends Node

var blocks: Dictionary
var items: Dictionary


func _ready() -> void:
	_generate_blocks()
	_generate_items()


func register_block(block: Block) -> void:
	blocks.merge({block.block_id: block})


func register_item(item: Item) -> void:
	items.merge({item.item_id: item})


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
	register_block(grass_block)

	var dirt_block := Block.new("dirt")
	dirt_block.voxel_id = 2
	dirt_block.name = "Dirt"
	dirt_block.color = Color.BROWN
	register_block(dirt_block)




func _generate_items() -> void:
	var grass_block_item := BlockItem.new("grass_block")
	grass_block_item.block_id = "grass"
	grass_block_item.name = "Grass Block"
	grass_block_item.texture = load("res://assets/textures/block/grass_block_side.png")
	register_item(grass_block_item)
	
	var dirt_block_item := BlockItem.new("dirt_block")
	dirt_block_item.block_id = "dirt"
	grass_block_item.name = "Dirt Block"
	dirt_block_item.texture = load("res://assets/textures/block/dirt.png")
	register_item(dirt_block_item)


# Apparently you can not set cube tiles in a script.....
func _generate_voxel_library() -> void:
	var library := VoxelBlockyLibrary.new()
	for block in blocks:
		var voxel := library.create_voxel(blocks[block].voxel_id, blocks[block].block_id)
		library.voxel_count += 1
