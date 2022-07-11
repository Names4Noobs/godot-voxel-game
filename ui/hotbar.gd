extends HBoxContainer

var inv_slot = load("res://ui/inventory_slot_display.tscn")
#var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")
@onready var inventory = $%VoxelInteraction/Inventory 
var icon_size := Vector2(64,64)
const HOTBAR_SIZE = 9
var selected_slot: int:
	set(v): 
		await _update_selector(v)
		selected_slot = v


func _ready() -> void:
	for i in range(HOTBAR_SIZE-1):
		var slot = inv_slot.instantiate()
#		if inventory.get_child(i) != null:
#			print("Setting texture")
#			slot.get_node("TextureRect").texture = inventory.get_child(i).texture
		add_child(slot)



func _update_selector(new_id: int) -> void:
	pass
	#get_child(selected_slot-1).get_node("ColorRect").hide()
	#get_child(new_id-1).get_node("ColorRect").show()

