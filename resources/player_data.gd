extends Resource
class_name PlayerData

@export var transform := Transform3D.IDENTITY
@export var velocity := Vector3.ZERO
@export var stats: Resource




func _init(p_stats=PlayerStats.new()) -> void:
	stats = p_stats
