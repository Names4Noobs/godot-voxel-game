extends RigidDynamicBody3D
class_name ItemDropEntity


var item: Resource:
	set(v):
		item = v
		_on_item_set()
var item_count := 0
var random_factor: float
var use_sprite: bool:
	set(v):
		_toggle_visibility(v)
		use_sprite = v

@onready var model := $CSGBox3D
@onready var sprite := $Sprite3D


func _ready() -> void:
	random_factor = randf_range(.5, 2.0)
	lock_rotation = true


func _physics_process(_delta: float) -> void:
	rotate_x(.01 * random_factor)
	rotate_y(.01 * random_factor)


func _make_item_material() -> StandardMaterial3D:
	var mat = StandardMaterial3D.new()
	if item != null:
		mat.albedo_texture = item.texture
	return mat


func _on_item_set() -> void:
	await self.ready
	if model != null:
		model.material = _make_item_material()
	if sprite != null:
		sprite.texture = item.texture
	use_sprite = item.is_drop_sprite


func _toggle_visibility(v: bool) -> void:
	if v == true:
		model.visible = false
		sprite.visible = true
