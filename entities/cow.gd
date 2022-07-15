extends RigidDynamicBody3D

var health = 100
var is_dead = false


func interact() -> void:
	print("You just interacted with a cow!")


func damage(amount: int) -> void:
	print("You just hit a cow!")
	health -= amount
	if health <= 0 and !is_dead:
		_make_head_red()
		$AnimationPlayer.play("die")
		is_dead = true
		Signals.emit_signal("drop_item", preload("res://data/blocks/beef_item.tres"))


func _make_head_red() -> void:
	$Head.material_override = _make_red_material()


static func _make_red_material() -> StandardMaterial3D:
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color.RED
	return mat
