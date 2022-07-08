extends Node



var ticks = 0
@onready var sun_light := $DirectionalLight3D
@export var enabled = true:
	set(v): 
		enabled = v
		_update_toggle()


func _ready() -> void:
	set_process(enabled)


func _update_toggle() -> void:
	set_process(enabled)


func _process(delta: float) -> void:
	ticks += 1
	if ticks % 60 == 0:
		sun_light.rotation.x += 0.1

