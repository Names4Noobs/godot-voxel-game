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

# NOTE: There seems to be some sort of parser error as of now.
# Block data
var air_block := load("res://data/blocks/air_block.tres")
var dirt_block := load("res://data/blocks/dirt_block.tres")
var grass_block_block := load("res://data/blocks/grass_block_block.tres")
var water_block := load("res://data/blocks/water_block.tres")
var sand_block := load("res://data/blocks/sand_block.tres")
var log_block := load("res://data/blocks/log_block.tres")
var leaf_block := load("res://data/blocks/leaf_block.tres")
var stone_block := load("res://data/blocks/stone_block.tres")
var coal_ore_block := load("res://data/blocks/coal_ore_block.tres")
var iron_ore_block := load("res://data/blocks/iron_ore_block.tres")
var gold_ore_block := load("res://data/blocks/gold_ore_block.tres")
var diamond_ore_block := load("res://data/blocks/diamond_ore_block.tres")
var lava_block := load("res://data/blocks/lava_block.tres")
var crafting_table_block := load("res://data/blocks/crafting_table_block.tres")
var furnace_block := load("res://data/blocks/furnace_block.tres")
var tnt_block := load("res://data/blocks/tnt_block.tres")


@onready var player_inventory = Inventory.new()


func _ready() -> void:
	# Block array
	blocks.append(air_block)
	blocks.append(dirt_block)
	blocks.append(grass_block_block)
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

	
	
	# Item array is sorted by voxel id
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
