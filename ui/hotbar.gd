extends HBoxContainer

var inv_slot = load("res://ui/inventory_slot_display.tscn")
#var voxel_library: VoxelBlockyLibrary = preload("res://data/voxel_library.tres")
@onready var inventory = $%VoxelInteraction/Inventory 
var icon_size := Vector2(64,64)
const HOTBAR_SIZE = 9

var slot_data: Array



var selected_slot: int:
	set(v): 
		await _update_selector(v)
		selected_slot = v


func _ready() -> void:
	Signals.connect("inventory_loaded", Callable(self, "_update_ui"))

func _update_ui(data: Array) -> void:
	var idx = 0
	for i in data:
		if get_child(idx) != null:
			get_child(idx).get_node("TextureRect").texture = i.item.texture
			get_child(idx).get_node("Label").text = str(i.quantity)
			idx += 1



func _update_selector(new_id: int) -> void:
	pass
	#get_child(selected_slot-1).get_node("ColorRect").hide()
	#get_child(new_id-1).get_node("ColorRect").show()

