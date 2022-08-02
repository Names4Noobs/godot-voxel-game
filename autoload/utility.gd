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

# Block items
var dirt_item := preload("res://data/items/dirt_item.tres")
var grass_item := preload("res://data/items/grass_item.tres")
var water_item := preload("res://data/items/water_item.tres")
var sand_item := preload("res://data/items/sand_item.tres")
var log_item := preload("res://data/items/log_item.tres")
var leaf_item := preload("res://data/items/leaf_item.tres")
var crafting_table_item := preload("res://data/items/crafting_table_item.tres")
var furnace_item := preload("res://data/items/furnace_item.tres")
var tnt_item := preload("res://data/items/tnt_item.tres")
var stone_item := preload("res://data/items/stone_item.tres")
var coal_ore_item := preload("res://data/items/coal_item.tres")
var iron_ore_item := preload("res://data/items/iron_item.tres")
var gold_ore_item := preload("res://data/items/gold_item.tres")
var diamond_ore_item := preload("res://data/items/diamond_item.tres")


# Consumable Items
var beef_item := preload("res://data/items/beef_item.tres")

# Tool items
var diamond_sword_item := preload("res://data/items/diamond_sword_item.tres")
var diamond_pickaxe_item := preload("res://data/items/diamond_pickaxe_item.tres")
var diamond_shovel_item := preload("res://data/items/diamond_shovel_item.tres")
var diamond_axe_item := preload("res://data/items/diamond_axe_item.tres")
var diamond_hoe_item := preload("res://data/items/diamond_hoe_item.tres")

# Projectile weapons
var bow_item := preload("res://data/items/bow_item.tres")




@onready var inventory = get_node("../Main/VoxelInteraction/Inventory")

func _ready() -> void:
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


func _get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport().global_canvas_transform
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport().get_visible_rect().size / scale / 2


# NOTE: Globally referencing the inventory should only be temporary;
# but, who knows?
func get_inventory() -> Node:
	return inventory
