extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var health := $Stats/Health
@onready var cow_model := $cow


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var random_dir := Vector3.ZERO

func _ready() -> void:
	health.connect("value_empty", kill)
	_change_dir()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * 4 * delta 
	if is_on_wall():
		velocity.y = JUMP_VELOCITY
	
	var direction := (transform.basis * random_dir).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()


func _change_dir() -> void:
	while true:
		random_dir = Vector3(randi_range(-1,1), 0, randi_range(-1,1))
		await get_tree().create_timer(2.75).timeout
		random_dir = Vector3.ZERO
		await get_tree().create_timer(7.5).timeout


func damage(amount: float) -> void:
	cow_model.get_node("AnimationPlayer").play("hurt")
	health.value -= amount
	health.is_regenerating = false
	health.start_cooldown_timer()


func kill() -> void:
	Game.create_item_drop(global_position, ItemStack.create_full_stack("log_block"))
	queue_free()
