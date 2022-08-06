extends Control


enum PlayerSkins {MAN, MAN1, WOMAN, WOMAN1}

var character_material := preload("res://assets/models/character/character_material_3d.tres")

var man_texture = preload("res://assets/models/character/skins/skin_man.png")
var man1_texture = preload("res://assets/models/character/skins/skin_manAlternative.png")
var woman_texture = preload("res://assets/models/character/skins/skin_woman.png")
var woman1_texture = preload("res://assets/models/character/skins/skin_womanAlternative.png")

@onready var skin_select: OptionButton = $VBoxContainer/PlayerSkin/OptionButton


func _ready() -> void:
	skin_select.connect("item_selected", Callable(self, "_change_skin"))
	skin_select.selected = PlayerSkins.MAN
	

func _change_skin(option: int) -> void:
	match option:
		PlayerSkins.MAN:
			character_material.albedo_texture = man_texture
		PlayerSkins.MAN1:
			character_material.albedo_texture = man1_texture
		PlayerSkins.WOMAN:
			character_material.albedo_texture = woman_texture
		PlayerSkins.WOMAN1:
			character_material.albedo_texture = woman1_texture
