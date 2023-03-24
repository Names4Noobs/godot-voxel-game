extends Control

@onready var game_info := $PanelContainer2/GameInfoOverlay
@onready var player_info := $PanelContainer/PlayerInfoOverlay
@onready var block_info := $PanelContainer3/BlockInfoOverlay


func _ready() -> void:
	disable()
	


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("toggle_debug"):
		# TODO: Disable child nodes when toggled
		disable() if visible else enable()


func enable() -> void:
	game_info.show()
	player_info.show()
	block_info.show()
	show()


func disable() -> void:
	game_info.hide()
	player_info.hide()
	block_info.hide()
	hide()
