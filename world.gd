class_name GameWorld
extends Node3D

const ItemDropScene := preload("res://misc/item_drop/item_drop.tscn")
const PlayerEntity := preload("res://entities/player/player.tscn")
const ZombieEntity := preload("res://entities/zombie/zombie.tscn")
const CowEntity := preload("res://entities/cow/cow.tscn")


var world_name := &"test"
var world_seed: int
var ticks: int
var gamemode := 0

@onready var voxel_terrain := $VoxelTerrain
@onready var sun := $Sun


func _ready() -> void:
	var save_path := "user://saves/%s/" % world_name
	voxel_terrain.generator = FlatlandGenerator.new()
	if not DirAccess.dir_exists_absolute(save_path+"regions"):
		DirAccess.make_dir_recursive_absolute(save_path+"regions")
	# NOTE: I think streams are broken on the build I am using
	#var stream := VoxelStreamRegionFiles.new()
	#stream.directory = save_path+"regions"
	#voxel_terrain.stream = stream
	_spawn_player()


func _physics_process(_delta: float) -> void:
	ticks += 1
	sun.rotate_x(0.001)


func save_game() -> void:
	var save_path := "user://saves/%s/" % world_name
	if not DirAccess.dir_exists_absolute(save_path):
		DirAccess.make_dir_recursive_absolute(save_path)
	var file := FileAccess.open(save_path+"world.dat", FileAccess.WRITE)
	if file:
		file.store_line(JSON.stringify(get_data()))
	else:
		printerr(FileAccess.get_open_error())
	

func load_game() -> void:
	pass


func create_item_drop(drop_position: Vector3, item_stack: ItemStack) -> ItemDrop:
	if item_stack == null:
		return
	var drop := ItemDropScene.instantiate()
	drop.position = drop_position
	drop.item_stack = item_stack
	add_child(drop)
	return drop


func create_player_inventory() -> Inventory:
	var inventory := Inventory.new(Player.INVENTORY_SLOTS)
	inventory.add_item_stack(ItemStack.create_full_stack("wooden_sword"))
	inventory.add_item_stack(ItemStack.create_full_stack("wooden_pickaxe"))
	inventory.add_item_stack(ItemStack.create_full_stack("wooden_axe"))
	inventory.add_item_stack(ItemStack.create_full_stack("wooden_shovel"))
	inventory.add_item_stack(ItemStack.create_full_stack("wooden_hoe"))
	inventory.add_item_stack(ItemStack.create_full_stack("leaf_block"))
	inventory.add_item_stack(ItemStack.create_full_stack("chest"))
	return inventory


func _spawn_player() -> void:
	var player := PlayerEntity.instantiate()
	player.voxel_terrain = voxel_terrain
	player.inventory = create_player_inventory()
	player.position = Vector3(0, 4.0, 0)
	add_child(player)
	Events.emit_signal("player_spawned", player)


func get_data() -> Dictionary:
	return {
		"world_name": world_name,
		"generator": "flat",
		"world_seed": world_seed,
		"world_time": ticks,
		"gamemode": gamemode,
		"world_border_size": 100000,
		"gamerules": {},
		"last_played": Time.get_unix_time_from_system(),
		"version": "Dev"
	}

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
