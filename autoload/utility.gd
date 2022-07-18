extends Node

# NOTE: This needs updated when the voxel library is updated
enum  Block {DIRT=1, GRASS=2, WATER=3, SAND=4, LOG=5, LEAF=6, STONE=7, 
COAL_ORE=8, IRON_ORE=9, GOLD_ORE=10, DIAMOND_ORE=11, LAVA=12, CRAFTING_TABLE=13, 
FURNACE=14}

enum BlockEntity {CRAFTING, FURNACE, TNT}

enum DamageReason {FALL, HIT, UNKNOWN}

var items: Array[Resource]

var _dirt_item := preload("res://data/items/dirt_item.tres")
var _grass_item := preload("res://data/items/grass_item.tres")
var _water_item := preload("res://data/items/water_item.tres")
var _sand_item := preload("res://data/items/sand_item.tres")
var _log_item := preload("res://data/items/log_item.tres")
var _leaf_item := preload("res://data/items/leaf_item.tres")
var _beef_item := preload("res://data/items/beef_item.tres")
var _crafting_table_item := preload("res://data/items/crafting_table_item.tres")
var _furnace_item := preload("res://data/items/furnace_item.tres")
var _tnt_item := preload("res://data/items/tnt_item.tres")

@onready var inventory = get_node("../Main/VoxelInteraction/Inventory")

func _ready() -> void:
	# Item array is sorted by voxel id
	items.append(_dirt_item)
	items.append(_dirt_item)
	items.append(_grass_item)
	items.append(_water_item)
	items.append(_sand_item) 
	items.append(_log_item)
	items.append(_leaf_item)
	items.append(_dirt_item)
	items.append(_dirt_item)
	items.append(_dirt_item)
	items.append(_dirt_item)
	items.append(_dirt_item)
	items.append(_dirt_item)
	items.append(_dirt_item)
	items.append(_crafting_table_item)
	items.append(_furnace_item)
	items.append(_tnt_item)


func _get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport().global_canvas_transform
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport().get_visible_rect().size / scale / 2


# NOTE: Globally referencing the inventory should only be temporary;
# but, who knows?
func get_inventory() -> Node:
	return inventory
