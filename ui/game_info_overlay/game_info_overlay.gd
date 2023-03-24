extends VBoxContainer


@onready var version_label := $GameVersion
@onready var godot_version_label := $GodotVersion


func _ready() -> void:
	if OS.has_feature("editor"):
		version_label.set_text("Commit: " + Game.get_git_hash())
	else:
		version_label.set_text("Version: indev")
	godot_version_label.text = "Godot version: " + Engine.get_version_info()["string"]




