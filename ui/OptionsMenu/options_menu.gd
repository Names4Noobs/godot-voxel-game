extends Control

@onready var tab_container: TabContainer = $HSplitContainer/Tabs
@onready var name_text_edit := $HSplitContainer/Tabs/General/VBoxContainer/HBoxContainer/TextEdit
@onready var fullscreen_toggle_button := $HSplitContainer/Tabs/Video/VBoxContainer/HBoxContainer2/Toggle
@onready var general_button := $HSplitContainer/Sections/GeneralButton
@onready var video_button := $HSplitContainer/Sections/VideoButton
@onready var controls_button := $HSplitContainer/Sections/ControlsButton
@onready var back_button := $MenuTopBar/Button


func _ready() -> void:
	back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))
	general_button.connect("pressed", Callable(func(): tab_container.set_current_tab(0)))
	video_button.connect("pressed", Callable(func(): tab_container.set_current_tab(1)))
	controls_button.connect("pressed", Callable(func(): tab_container.set_current_tab(2)))
	general_button.grab_focus()
	name_text_edit.text = "Bob"
	get_viewport()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()


func _on_back_button_pressed() -> void:
	queue_free()
