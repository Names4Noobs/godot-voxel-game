extends Node

# NOTE: This needs updated when the voxel library is updated
enum  Block {AIR=0, DIRT=1, GRASS=2, WATER=3, SAND=4, LOG=5, LEAF=6, STONE=7, 
COAL_ORE=8, IRON_ORE=9, GOLD_ORE=10, DIAMOND_ORE=11, LAVA=12, CRAFTING_TABLE=13, 
FURNACE=14}

enum ItemType {BLOCK, CONSUMABLE, BLOCK_ENTITY, PROJECTILE, NONE}

enum ToolType {NONE, SWORD, PICKAXE, AXE, SHOVEL, HOE}

enum BlockEntity {CRAFTING, FURNACE, TNT}

enum DamageType {MELEE, RANGED, FALL, FIRE, UNKNOWN}

enum MonsterType {ZOMBIE}

enum ProjectileType {ARROW}

var items: Array[Resource]
var blocks: Array[Resource]

# Block items
var dirt_item := load("res://data/items/dirt_item.tres")
var grass_item := load("res://data/items/grass_item.tres")
var water_item := load("res://data/items/water_item.tres")
var sand_item := load("res://data/items/sand_item.tres")
var log_item := load("res://data/items/log_item.tres")
var leaf_item := load("res://data/items/leaf_item.tres")
var crafting_table_item := load("res://data/items/crafting_table_item.tres")
var furnace_item := load("res://data/items/furnace_item.tres")
var tnt_item := load("res://data/items/tnt_item.tres")
var stone_item := load("res://data/items/stone_item.tres")
var coal_ore_item := load("res://data/items/coal_item.tres")
var iron_ore_item := load("res://data/items/iron_item.tres")
var gold_ore_item := load("res://data/items/gold_item.tres")
var diamond_ore_item := load("res://data/items/diamond_item.tres")

# Consumable item data
var beef_item := load("res://data/items/beef_item.tres")

# Tool item data
var diamond_sword_item := load("res://data/items/diamond_sword_item.tres")
var diamond_pickaxe_item := load("res://data/items/diamond_pickaxe_item.tres")
var diamond_shovel_item := load("res://data/items/diamond_shovel_item.tres")
var diamond_axe_item := load("res://data/items/diamond_axe_item.tres")
var diamond_hoe_item := load("res://data/items/diamond_hoe_item.tres")

# Projectile weapons
var bow_item := preload("res://data/items/bow_item.tres")

# TODO: Once the editor is updated, take advantage of custom resource type hints
var air_block: Resource
var dirt_block: Resource
var grass_block: Resource
var water_block: Resource
var sand_block: Resource
var log_block: Resource
var leaf_block: Resource
var stone_block: Resource
var coal_ore_block: Resource
var iron_ore_block: Resource
var gold_ore_block: Resource
var diamond_ore_block: Resource
var lava_block: Resource
var crafting_table_block: Resource
var furnace_block: Resource
var tnt_block: Resource


@onready var player_inventory = Inventory.new()


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_generate_block_data()
	# Populate blocks array sorted by voxel_id
	blocks.append(air_block)
	blocks.append(dirt_block)
	blocks.append(grass_block)
	blocks.append(water_block)
	blocks.append(sand_block) 
	blocks.append(log_block)
	blocks.append(leaf_block)
	blocks.append(stone_block)
	blocks.append(coal_ore_block)
	blocks.append(iron_ore_block)
	blocks.append(gold_ore_block)
	blocks.append(diamond_ore_block)
	blocks.append(dirt_block)
	blocks.append(crafting_table_block)
	blocks.append(furnace_block)
	blocks.append(tnt_block)


	# Item array is sorted by voxel_id
	items.append(dirt_item)
	items.append(dirt_item)
	items.append(grass_item)
	items.append(water_item)
	items.append(sand_item) 
	items.append(log_item)
	items.append(leaf_item)
	items.append(stone_item)
	items.append(coal_ore_item)
	items.append(iron_ore_item)
	items.append(gold_ore_item)
	items.append(diamond_ore_item)
	items.append(dirt_item)
	items.append(crafting_table_item)
	items.append(furnace_item)
	items.append(tnt_item)
	items.append(beef_item)
	items.append(diamond_sword_item)
	items.append(diamond_pickaxe_item)
	items.append(diamond_shovel_item)
	items.append(diamond_axe_item)
	items.append(diamond_hoe_item)
	items.append(bow_item)

func _generate_item_data() -> void:
	pass



func _generate_block_data() -> void:
	air_block = BlockData.new()
	air_block.name = "Air"
	air_block.voxel_id = Block.AIR
	air_block.can_break = false
	dirt_block = BlockData.new()
	dirt_block.name = "Dirt"
	dirt_block.voxel_id = Block.DIRT
	dirt_block.tool_type = ToolType.AXE
	grass_block = BlockData.new()
	grass_block.name = "Grass Block"
	grass_block.voxel_id = Block.GRASS
	grass_block.tool_type = ToolType.AXE
	water_block = BlockData.new()
	water_block.name = "Water"
	water_block.voxel_id = Block.WATER
	water_block.can_break = false
	sand_block = BlockData.new()
	sand_block.name = "Sand"
	sand_block.voxel_id = Block.SAND
	sand_block.tool_type = ToolType.SHOVEL
	log_block = BlockData.new()
	log_block.name = "Log"
	log_block.voxel_id = Block.LOG
	log_block.tool_type = ToolType.AXE
	leaf_block = BlockData.new()
	leaf_block.name = "Leaves"
	leaf_block.voxel_id = Block.LEAF
	stone_block = BlockData.new()
	stone_block.name = "Stone"
	stone_block.voxel_id = Block.STONE
	stone_block.tool_type = ToolType.PICKAXE
	coal_ore_block = BlockData.new()
	coal_ore_block.name = "Coal Ore"
	coal_ore_block.voxel_id = Block.COAL_ORE
	iron_ore_block = BlockData.new()
	iron_ore_block.name = "Iron Ore"
	iron_ore_block.voxel_id = Block.IRON_ORE
	iron_ore_block.tool_type = ToolType.PICKAXE
	gold_ore_block = BlockData.new()
	gold_ore_block.name = "Gold Ore"
	gold_ore_block.voxel_id = Block.GOLD_ORE
	gold_ore_block.tool_type = ToolType.PICKAXE
	diamond_ore_block = BlockData.new()
	diamond_ore_block.name = "Diamond Ore"
	diamond_ore_block.voxel_id = Block.DIAMOND_ORE
	diamond_ore_block.tool_type = ToolType.PICKAXE
	crafting_table_block = BlockData.new()
	crafting_table_block.name = "Crafting Table"
	crafting_table_block.voxel_id = Block.CRAFTING_TABLE
	crafting_table_block.tool_type = ToolType.AXE
	furnace_block = BlockData.new()
	furnace_block.name = "Furnace"
	furnace_block.voxel_id = Block.FURNACE
	furnace_block.tool_type = ToolType.PICKAXE
	lava_block = BlockData.new()
	lava_block.name = "Lava"
	lava_block.voxel_id = Block.LAVA
	lava_block.can_break = false



func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_fullscreen"):
		Settings.fullscreen = !Settings.fullscreen
	elif Input.is_action_just_pressed("take_screenshot"):
		await RenderingServer.frame_post_draw
		var dir := Directory.new()
		if !dir.dir_exists("user://screenshots/"):
			dir.make_dir("user://screenshots/")
		var screenshot_string = "{year}-{month}-{day}_{hour}.{minute}.{second}"
		var formatted_string = screenshot_string.format(Time.get_datetime_dict_from_system())
		get_viewport().get_texture().get_image().save_png("user://screenshots/" + formatted_string + ".png")


func _get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport().global_canvas_transform
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport().get_visible_rect().size / scale / 2


func get_player_inventory() -> Resource:
	return player_inventory


static func get_tool_type_string(p_tool_type: int) -> String:
	match p_tool_type:
		ToolType.NONE:
			return "None"
		ToolType.SWORD:
			return "Sword"
		ToolType.PICKAXE:
			return "Pickaxe"
		ToolType.AXE:
			return "Axe"
		ToolType.SHOVEL:
			return "Shovel"
		ToolType.HOE:
			return "Hoe"
		_:
			return "Invalid tool type!"
	# NOTE: The only reason this is here is because it caused the windows export 
	# to fail for some reason. Once this is fixed, it can be removed. 
	return ""
