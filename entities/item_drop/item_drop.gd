extends RigidBody3D
class_name ItemDropEntity


var item: Resource:
	set(v):
		item = v
		_on_item_set()
var item_count := 0:
	set(v):
		$Label3D.text = str(v)
		if v <= 1:
			$Label3D.visible = false
		else:
			$Label3D.visible = true
		item_count = v
var random_factor: float
var use_sprite: bool:
	set(v):
		_toggle_visibility(v)
		use_sprite = v

@onready var model: CSGBox3D = $CSGBox3D
@onready var sprite: Sprite3D = $Sprite3D
@onready var quantity_label: Label3D = $Label3D


func _ready() -> void:
	random_factor = randf_range(.5, 2.0)
	collision_layer = 3
	collision_mask = 1
	lock_rotation = true


func _physics_process(_delta: float) -> void:
	rotate_x(.01 * random_factor)
	rotate_y(.01 * random_factor)
	if quantity_label.visible:
		quantity_label.position = self.position + Vector3.UP 


func _make_item_material() -> StandardMaterial3D:
	var mat = StandardMaterial3D.new()
	if item != null:
		mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
		mat.albedo_texture = item.texture
	return mat


func _on_item_set() -> void:
	await self.ready
	if model != null:
		model.material = _make_item_material()
	if sprite != null:
		sprite.texture = item.texture
	if item is BlockItemData:
		use_sprite = false
	else:
		use_sprite = true


func _toggle_visibility(v: bool) -> void:
	if v == true:
		model.visible = false
		sprite.visible = true
