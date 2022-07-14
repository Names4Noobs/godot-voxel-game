extends Node3D

const MyGenerator = preload("res://misc/voxel_generator.gd")

@onready var terrain: VoxelTerrain = $VoxelTerrain



func _ready() -> void:
	terrain.generator = MyGenerator.new()


