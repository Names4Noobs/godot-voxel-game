class_name GameWorld
extends Node3D

const ItemDropScene := preload("res://misc/item_drop/item_drop.tscn")
const PlayerEntity := preload("res://entities/player/player.tscn")
const ZombieEntity := preload("res://entities/zombie/zombie.tscn")
const CowEntity := preload("res://entities/cow/cow.tscn")

@onready var voxel_terrain := $VoxelTerrain
@onready var sun := $Sun


func _ready() -> void:
	voxel_terrain.generator = FlatlandGenerator.new()
	_spawn_player()


func _physics_process(_delta: float) -> void:
	sun.rotate_x(0.001)


func create_item_drop(drop_position: Vector3, item_stack: ItemStack) -> ItemDrop:
	if item_stack == null:
		return
	var drop := ItemDropScene.instantiate()
	drop.position = drop_position
	drop.item_stack = item_stack
	add_child(drop)
	return drop


func _spawn_player() -> void:
	var player := PlayerEntity.instantiate()
	player.voxel_terrain = voxel_terrain
	player.inventory = Inventory.new(Player.INVENTORY_SLOTS)
	player.position = Vector3(0, 4.0, 0)
	add_child(player)
	Events.emit_signal("player_spawned", player)
