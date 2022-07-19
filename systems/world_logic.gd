extends Node


@export var enabled = true:
	set(v): 
		set_process(v)
		enabled = v

var world_data: Resource

@onready var sun_light := $DirectionalLight3D

func _ready() -> void:
	world_data = WorldData.new()


func _process(_delta: float) -> void:
	world_data.seconds += 1
	
	# Every in game minute rotate the sun by .3 degrees.
	if world_data.seconds % 60 == 0:
		sun_light.rotation.x += deg2rad(0.3)
	
	if world_data.seconds % 86400 == 0:
		print("A day has passed!")
