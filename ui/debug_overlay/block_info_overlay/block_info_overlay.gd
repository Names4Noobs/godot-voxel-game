extends VBoxContainer

var player: Player

@onready var position_label := $Position
@onready var name_label := $Name
@onready var block_texture_rect := $TextureRect

func _ready() -> void:
	Events.connect("player_spawned", func(v): player = v)


func _physics_process(_delta: float) -> void:
	if not visible or not player:
		return
	var result = player.voxel_interactor.get_pointed_voxel()
	if result:
		position_label.set_text("Selected block: " + str(result.position))
		var block: Block = player.voxel_interactor.get_pointed_block_data()
		if block:
			name_label.set_text("Name: " + block.name)
			# TODO: Make block model renders easier to get.
			# Loading the same resource over and over is not good
			var path := "res://assets/textures/item/%s.png" % block.name.to_lower()
			if ResourceLoader.exists(path):
				block_texture_rect.set_texture(load(path))
			else:
				block_texture_rect.set_texture(null)
			
	else:
		position_label.set_text("Selected block: ")
		name_label.set_text("Name: ")
		block_texture_rect.set_texture(null)
		
