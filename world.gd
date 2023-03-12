extends Node3D

@onready var sun := $Sun 

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(_delta: float) -> void:
	sun.rotate_x(0.001)
