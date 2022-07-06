extends RigidDynamicBody3D

var data := EntityData.new()
var data_path := "res://data/entity_cube.tres"


func _ready() -> void:
	_load_data()


func _exit_tree() -> void:
	_save_data()


func _save_data() -> void:
	data.transform = global_transform
	var result = ResourceSaver.save("res://data/entity_cube.tres", data)
	match result:
		OK:
			print_verbose(str(self) + ": Succesfully saved data.")
		_:
			print(str(self) + ": Failed to save data. Error code: " + str(result))


func _load_data() -> void:
	if ResourceLoader.exists(data_path):
		var tmp_data = ResourceLoader.load(data_path)
		if tmp_data is EntityData:
			data = tmp_data
			_apply_data()
			print_verbose(str(self) + ":Succesfully loaded data.")
			
	else:
		print(str(self) + ": Failed to load data. File does not exist.")


func _apply_data() -> void:
	global_transform = data.transform

# set_notify_transform(true)
#func _notification(what: int) -> void:
#	match what:
#		NOTIFICATION_TRANSFORM_CHANGED:
#			print(self.global_transform)
