extends Node

# NOTE: This needs updated when the voxel library is updated
enum  Block {AIR=0, DIRT=1, GRASS=2, WATER=3, SAND=4, LOG=5, LEAF=6, STONE=7, 
COAL_ORE=8, IRON_ORE=9, GOLD_ORE=10, DIAMOND_ORE=11, LAVA=12, CRAFTING_TABLE=13, 
FURNACE=14, TNT=15, PLANKS=16}
enum ItemType {BLOCK, CONSUMABLE, BLOCK_ENTITY, PROJECTILE, NONE}
enum ToolType {NONE, SWORD, PICKAXE, AXE, SHOVEL, HOE}
enum BlockEntity {CRAFTING, FURNACE, TNT}
enum DamageType {MELEE, RANGED, FALL, FIRE, UNKNOWN}
enum MonsterType {ZOMBIE}
enum ProjectileType {ARROW}

var items: Array[ItemData] = []
var blocks: Array[BlockData] = []
var recipes: Array[CraftingRecipe] = []

var planks_crafting_recipe: CraftingRecipe
var diamond_sword_recipe: CraftingRecipe
var diamond_pickaxe_recipe: CraftingRecipe
var diamond_axe_recipe: CraftingRecipe
var diamond_shovel_recipe: CraftingRecipe
var diamond_hoe_recipe: CraftingRecipe

var dirt_block_item: BlockItemData
var grass_block_item: BlockItemData
var water_block_item: BlockItemData
var sand_block_item: BlockItemData
var log_block_item: BlockItemData
var leaf_block_item: BlockItemData
var crafting_table_block_item: BlockEntityItemData
var furnace_block_item: BlockEntityItemData
var tnt_block_item: BlockEntityItemData
var stone_block_item: BlockItemData
var coal_ore_block_item: BlockItemData
var iron_ore_block_item: BlockItemData
var gold_ore_block_item: BlockItemData
var diamond_ore_block_item: BlockItemData
var wood_planks_block_item: BlockItemData
var beef_consumable_item: ConsumableItemData
var diamond_sword_item: ToolItemData
var diamond_pickaxe_item: ToolItemData
var diamond_shovel_item: ToolItemData
var diamond_axe_item: ToolItemData
var diamond_hoe_item: ToolItemData
var bow_item: ItemData
var stick_item: ItemData
var apple_item: ItemData
var diamond_item: ItemData
var gold_item: ItemData
var iron_item: ItemData
var coal_item: ItemData

var air_block: BlockData
var dirt_block: BlockData
var grass_block: BlockData
var water_block: BlockData
var sand_block: BlockData
var log_block: BlockData
var leaf_block: BlockData
var stone_block: BlockData
var coal_ore_block: BlockData
var iron_ore_block: BlockData
var gold_ore_block: BlockData
var diamond_ore_block: BlockData
var lava_block: BlockData
var crafting_table_block: BlockData
var furnace_block: BlockData
var tnt_block: BlockData
var wood_planks_block: BlockData


@onready var player_inventory = Inventory.new()

func _init() -> void:
	_generate_item_data()
	_generate_block_data()
	_generate_crafting_recipe_data()
	
	recipes.append(planks_crafting_recipe)
	recipes.append(diamond_sword_recipe)
	recipes.append(diamond_pickaxe_recipe)
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
	blocks.append(lava_block)
	blocks.append(crafting_table_block)
	blocks.append(furnace_block)
	blocks.append(tnt_block)
	blocks.append(wood_planks_block)
	# Populate items array
	# NOTE: This doesn't have to be sorted
	items.append(dirt_block_item)
	items.append(grass_block_item)
	items.append(water_block_item)
	items.append(sand_block_item) 
	items.append(log_block_item)
	items.append(leaf_block_item)
	items.append(stone_block_item)
	items.append(coal_ore_block_item)
	items.append(iron_ore_block_item)
	items.append(gold_ore_block_item)
	items.append(diamond_ore_block_item)
	items.append(crafting_table_block_item)
	items.append(furnace_block_item)
	items.append(tnt_block_item)
	items.append(beef_consumable_item)
	items.append(diamond_sword_item)
	items.append(diamond_pickaxe_item)
	items.append(diamond_shovel_item)
	items.append(diamond_axe_item)
	items.append(diamond_hoe_item)
	items.append(bow_item)
	items.append(wood_planks_block_item)
	items.append(stick_item)
	items.append(apple_item)
	items.append(coal_item)
	items.append(iron_item)
	items.append(gold_item)
	items.append(diamond_item)


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _generate_crafting_recipe_data() -> void:
	planks_crafting_recipe = CraftingRecipe.new()
	planks_crafting_recipe.item_1 = log_block_item
	planks_crafting_recipe.item_1_quantity = 1
	planks_crafting_recipe.crafted_item = wood_planks_block_item
	diamond_sword_recipe = CraftingRecipe.new()
	diamond_sword_recipe.item_1 = diamond_item
	diamond_sword_recipe.item_1_quantity = 2
	diamond_sword_recipe.item_2 = stick_item
	diamond_sword_recipe.item_2_quantity = 1
	diamond_sword_recipe.crafted_item = diamond_sword_item
	diamond_pickaxe_recipe = CraftingRecipe.new()
	diamond_pickaxe_recipe.item_1 = diamond_item
	diamond_pickaxe_recipe.item_1_quantity = 3
	diamond_pickaxe_recipe.item_2 = stick_item
	diamond_pickaxe_recipe.item_2_quantity = 2
	diamond_pickaxe_recipe.crafted_item = diamond_pickaxe_item


func _generate_item_data() -> void:
	dirt_block_item = BlockItemData.new()
	dirt_block_item.name = "Dirt"
	dirt_block_item.texture = preload("res://assets/textures/block/dirt.png")
	dirt_block_item.voxel_id = Block.DIRT
	grass_block_item = BlockItemData.new()
	grass_block_item.name = "Grass Block"
	grass_block_item.texture = preload("res://assets/textures/block/grass_block_side.png")
	grass_block_item.voxel_id = Block.GRASS
	water_block_item = BlockItemData.new()
	water_block_item.name = "Water"
	water_block_item.texture = preload("res://assets/textures/block/water.png")
	water_block_item.voxel_id = Block.WATER
	sand_block_item = BlockItemData.new()
	sand_block_item.name = "Sand"
	sand_block_item.texture = preload("res://assets/textures/block/sand.png")
	sand_block_item.voxel_id = Block.SAND
	log_block_item = BlockItemData.new()
	log_block_item.name = "Log"
	log_block_item.texture = preload("res://assets/textures/block/dark_oak_log.png")
	log_block_item.voxel_id = Block.LOG
	leaf_block_item = BlockItemData.new()
	leaf_block_item.name = "Leaves"
	leaf_block_item.texture = preload("res://assets/textures/block/dark_oak_leaves.png")
	leaf_block_item.voxel_id = Block.LEAF
	stone_block_item = BlockItemData.new()
	stone_block_item.name = "Stone"
	stone_block_item.texture = preload("res://assets/textures/block/stone.png")
	stone_block_item.voxel_id = Block.STONE
	coal_ore_block_item = BlockItemData.new()
	coal_ore_block_item.name = "Coal Ore"
	coal_ore_block_item.texture = preload("res://assets/textures/block/coal_ore.png")
	coal_ore_block_item.voxel_id = Block.COAL_ORE
	iron_ore_block_item = BlockItemData.new()
	iron_ore_block_item.name = "Iron Ore"
	iron_ore_block_item.texture = preload("res://assets/textures/block/iron_ore1.png")
	iron_ore_block_item.voxel_id = Block.IRON_ORE
	gold_ore_block_item = BlockItemData.new()
	gold_ore_block_item.name = "Gold Ore"
	gold_ore_block_item.texture = preload("res://assets/textures/block/gold_ore.png")
	gold_ore_block_item.voxel_id = Block.GOLD_ORE
	diamond_ore_block_item = BlockItemData.new()
	diamond_ore_block_item.name = "Diamond Ore"
	diamond_ore_block_item.texture = preload("res://assets/textures/block/diamond_ore1.png")
	diamond_ore_block_item.voxel_id = Block.DIAMOND_ORE
	crafting_table_block_item = BlockEntityItemData.new()
	crafting_table_block_item.name = "Crafting Table"
	crafting_table_block_item.texture = preload("res://assets/textures/block/crafting_table_side.png")
	crafting_table_block_item.voxel_id = Block.FURNACE
	furnace_block_item = BlockEntityItemData.new()
	furnace_block_item.name = "Furnace"
	furnace_block_item.texture = preload("res://assets/textures/block/furnace_front.png")
	furnace_block_item.voxel_id = Block.FURNACE
	tnt_block_item = BlockEntityItemData.new()
	tnt_block_item.name = "TNT"
	tnt_block_item.texture = preload("res://assets/textures/block/tnt_side.png")
	tnt_block_item.voxel_id = Block.TNT
	tnt_block_item.block_entity_type = BlockEntity.TNT
	wood_planks_block_item = BlockItemData.new()
	wood_planks_block_item.name = "Wood Planks"
	wood_planks_block_item.texture = preload("res://assets/textures/block/oak_planks.png")
	wood_planks_block_item.voxel_id = 16
	beef_consumable_item = ConsumableItemData.new()
	beef_consumable_item.name = "Beef"
	beef_consumable_item.texture = preload("res://assets/textures/item/beef.png")
	diamond_sword_item = ToolItemData.new()
	diamond_sword_item.name = "Diamond Sword"
	diamond_sword_item.texture = preload("res://assets/textures/item/diamond_sword.png")
	diamond_sword_item.tool_type = ToolType.SWORD
	diamond_pickaxe_item = ToolItemData.new()
	diamond_pickaxe_item.name = "Diamond Pickaxe"
	diamond_pickaxe_item.texture = preload("res://assets/textures/item/diamond_pickaxe.png")
	diamond_pickaxe_item.tool_type = ToolType.PICKAXE
	diamond_axe_item = ToolItemData.new()
	diamond_axe_item.name = "Diamond Axe"
	diamond_axe_item.texture = preload("res://assets/textures/item/diamond_axe.png")
	diamond_axe_item.tool_type = ToolType.AXE
	diamond_shovel_item = ToolItemData.new()
	diamond_shovel_item.name = "Diamond Shovel"
	diamond_shovel_item.texture = preload("res://assets/textures/item/diamond_shovel.png")
	diamond_shovel_item.tool_type = ToolType.SHOVEL
	diamond_hoe_item = ToolItemData.new()
	diamond_hoe_item.name = "Diamond Hoe"
	diamond_hoe_item.texture = preload("res://assets/textures/item/diamond_hoe.png")
	diamond_hoe_item.tool_type = ToolType.HOE
	bow_item = ItemData.new()
	bow_item.name = "Bow"
	bow_item.texture = preload("res://assets/textures/item/bow.png")
	stick_item = ItemData.new()
	stick_item.name = "Stick"
	stick_item.texture = preload("res://assets/textures/item/stick.png")
	apple_item = ItemData.new()
	apple_item.name = "Apple"
	apple_item.texture = preload("res://assets/textures/item/apple.png")
	coal_item = ItemData.new()
	coal_item.name = "Coal"
	coal_item.texture = preload("res://assets/textures/item/coal.png")
	iron_item = ItemData.new()
	iron_item.name = "Iron"
	iron_item.texture = preload("res://assets/textures/item/iron_ingot.png")
	gold_item = ItemData.new()
	gold_item.name = "Gold"
	gold_item.texture = preload("res://assets/textures/item/gold_ingot.png")
	diamond_item = ItemData.new()
	diamond_item.name = "Diamond"
	diamond_item.texture = preload("res://assets/textures/item/diamond.png")


func _generate_block_data() -> void:
	air_block = BlockData.new()
	air_block.name = "Air"
	air_block.voxel_id = Block.AIR
	air_block.can_break = false
	dirt_block = BlockData.new()
	dirt_block.name = "Dirt"
	dirt_block.voxel_id = Block.DIRT
	dirt_block.drop_item = dirt_block_item
	dirt_block.tool_type = ToolType.SHOVEL
	grass_block = BlockData.new()
	grass_block.name = "Grass Block"
	grass_block.voxel_id = Block.GRASS
	grass_block.drop_item = grass_block_item
	grass_block.tool_type = ToolType.SHOVEL
	water_block = BlockData.new()
	water_block.name = "Water"
	water_block.voxel_id = Block.WATER
	water_block.drop_item = water_block_item
	water_block.can_break = false
	sand_block = BlockData.new()
	sand_block.name = "Sand"
	sand_block.voxel_id = Block.SAND
	sand_block.drop_item = sand_block_item
	sand_block.tool_type = ToolType.SHOVEL
	log_block = BlockData.new()
	log_block.name = "Log"
	log_block.voxel_id = Block.LOG
	log_block.drop_item = log_block_item
	log_block.tool_type = ToolType.AXE
	leaf_block = BlockData.new()
	leaf_block.name = "Leaves"
	leaf_block.voxel_id = Block.LEAF
	log_block.drop_item = log_block_item
	stone_block = BlockData.new()
	stone_block.name = "Stone"
	stone_block.voxel_id = Block.STONE
	stone_block.drop_item = stone_block_item
	stone_block.tool_type = ToolType.PICKAXE
	coal_ore_block = BlockData.new()
	coal_ore_block.name = "Coal Ore"
	coal_ore_block.voxel_id = Block.COAL_ORE
	coal_ore_block.drop_item = coal_item
	iron_ore_block = BlockData.new()
	iron_ore_block.name = "Iron Ore"
	iron_ore_block.voxel_id = Block.IRON_ORE
	iron_ore_block.drop_item = iron_ore_block_item
	iron_ore_block.tool_type = ToolType.PICKAXE
	gold_ore_block = BlockData.new()
	gold_ore_block.name = "Gold Ore"
	gold_ore_block.voxel_id = Block.GOLD_ORE
	gold_ore_block.drop_item = gold_ore_block_item
	gold_ore_block.tool_type = ToolType.PICKAXE
	diamond_ore_block = BlockData.new()
	diamond_ore_block.name = "Diamond Ore"
	diamond_ore_block.voxel_id = Block.DIAMOND_ORE
	diamond_ore_block.drop_item = diamond_item
	diamond_ore_block.tool_type = ToolType.PICKAXE
	crafting_table_block = BlockData.new()
	crafting_table_block.name = "Crafting Table"
	crafting_table_block.voxel_id = Block.CRAFTING_TABLE
	crafting_table_block.drop_item = crafting_table_block_item
	crafting_table_block.tool_type = ToolType.AXE
	furnace_block = BlockData.new()
	furnace_block.name = "Furnace"
	furnace_block.voxel_id = Block.FURNACE
	furnace_block.drop_item = furnace_block_item
	furnace_block.tool_type = ToolType.PICKAXE
	lava_block = BlockData.new()
	lava_block.name = "Lava"
	lava_block.voxel_id = Block.LAVA
	lava_block.drop_item = dirt_block_item
	lava_block.can_break = false
	tnt_block = BlockData.new()
	tnt_block.name = "TNT"
	tnt_block.voxel_id = Block.TNT
	tnt_block.drop_item = tnt_block_item
	wood_planks_block = BlockData.new()
	wood_planks_block.name = "Wood Planks"
	wood_planks_block.voxel_id = Block.PLANKS
	wood_planks_block.drop_item = wood_planks_block_item


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_fullscreen"):
		Settings.fullscreen = !Settings.fullscreen
	elif Input.is_action_just_pressed("take_screenshot"):
		await RenderingServer.frame_post_draw
		var dir := DirAccess.new()
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
