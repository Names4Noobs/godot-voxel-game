extends Control

@onready var tab_container: TabContainer = $HSplitContainer/Tabs
@onready var profile_name_edit := $HSplitContainer/Tabs/Profile/VBoxContainer/HBoxContainer/TextEdit
@onready var profile_button := $HSplitContainer/ScrollContainer/Sections/ProfileButton
@onready var video_button := $HSplitContainer/ScrollContainer/Sections/VideoButton
@onready var controls_button := $HSplitContainer/ScrollContainer/Sections/ControlsButton
@onready var audio_button := $HSplitContainer/ScrollContainer/Sections/AudioButton
@onready var language_button := $HSplitContainer/ScrollContainer/Sections/LanguageButton
@onready var back_button := $MenuTopBar/Button


func _ready() -> void:
	back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))
	profile_button.connect("pressed", Callable(func(): tab_container.set_current_tab(0)))
	video_button.connect("pressed", Callable(func(): tab_container.set_current_tab(1)))
	audio_button.connect("pressed", Callable(func(): tab_container.set_current_tab(2)))
	language_button.connect("pressed", Callable(func(): tab_container.set_current_tab(3)))
	controls_button.connect("pressed", Callable(func(): tab_container.set_current_tab(4)))
	profile_button.grab_focus()
	profile_name_edit.set_text("Bob")
	get_viewport()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		close_menu()


func _on_back_button_pressed() -> void:
	close_menu()

func close_menu() -> void:
	get_parent().resume_button.grab_focus()
	queue_free()
