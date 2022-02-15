extends KinematicBody

const GRAVITY = -24.8
const MAX_SPEED = 20
const JUMP_SPEED = 18
const ACCEL = 4.5
const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40

var MOUSE_SENSITIVITY = 0.05


var _velocity := Vector3()
var _dir := Vector3()

onready var camera = $Spatial/Camera
onready var head = $Spatial

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta: float) -> void:
	_process_input(delta)
	_process_movement(delta)

func _process_input(_delta: float) -> void:
	_dir = Vector3()
	var cam_xform = camera.get_global_transform()
	var _input_dir := Vector2()
	if Input.is_action_pressed("move_down"):
		_input_dir = Vector2.DOWN
	elif Input.is_action_pressed("move_up"):
		_input_dir = Vector2.UP
	elif Input.is_action_pressed("move_left"):
		_input_dir = Vector2.LEFT
	elif Input.is_action_pressed("move_right"):
		_input_dir = Vector2.RIGHT
	
	_input_dir = _input_dir.normalized()
	
	_dir += cam_xform.basis.z * _input_dir.y
	_dir += cam_xform.basis.x * _input_dir.x

	if is_on_floor():
		if Input.is_action_just_pressed("ui_select"):
			_velocity.y = JUMP_SPEED

	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process_movement(delta: float) -> void:
	_dir.y = 0
	_dir = _dir.normalized()
	
	_velocity.y += delta * GRAVITY

	var hvel = _velocity
	hvel.y = 0

	var target = _dir
	target *= MAX_SPEED

	var accel
	if _dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel * delta)
	_velocity.x = hvel.x
	_velocity.z = hvel.z
	
	_velocity = move_and_slide(_velocity, Vector3.UP, 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = head.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		head.rotation_degrees = camera_rot

