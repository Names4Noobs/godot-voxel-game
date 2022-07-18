extends Resource
class_name PlayerData

@export var transform := Transform3D.IDENTITY
@export var velocity := Vector3.ZERO
var stats: = PlayerStats.new()




func _init() -> void:
	pass
