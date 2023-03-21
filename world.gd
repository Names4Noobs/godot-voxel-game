extends Node3D

@onready var voxel_terrain := $VoxelTerrain
@onready var sun := $Sun 

func _ready() -> void:
	voxel_terrain.generator = FlatlandGenerator.new()


func _physics_process(_delta: float) -> void:
	sun.rotate_x(0.001)
