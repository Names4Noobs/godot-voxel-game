extends Resource
class_name PlayerData

@export var transform := Transform3D.IDENTITY
@export var velocity := Vector3.ZERO


# Player stats
@export var health := 100
@export var hunger := 100
@export var stamina := 5.0


func _init() -> void:
	pass
