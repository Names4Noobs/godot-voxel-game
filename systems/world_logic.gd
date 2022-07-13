extends Node


# In game "seconds". This is equivalent to 1/60th of a real second.
var seconds = 0
@onready var sun_light := $DirectionalLight3D
@export var enabled = true:
	set(v): 
		set_process(v)
		enabled = v



func _process(_delta: float) -> void:
	seconds += 1
	
	# Every in game minute rotate the sun by .3 degrees.
	if seconds % 60 == 0:
		sun_light.rotation.x += deg2rad(0.3)

	if seconds % 86400 == 0:
		print("A day has passed!")
		
