extends Control

@onready var tab_container: TabContainer = $HSplitContainer/Tabs

@onready var profile_button: Button = $HSplitContainer/ScrollContainer/Sections/ProfileButton
@onready var video_button: Button = $HSplitContainer/ScrollContainer/Sections/VideoButton
@onready var controls_button: Button = $HSplitContainer/ScrollContainer/Sections/ControlsButton
@onready var audio_button: Button = $HSplitContainer/ScrollContainer/Sections/AudioButton
@onready var language_button: Button = $HSplitContainer/ScrollContainer/Sections/LanguageButton
@onready var back_button: Button = $MenuTopBar/Button

@onready var select_audio: AudioStreamPlayer = $SelectAudio
@onready var back_audio: AudioStreamPlayer = $BackAudio
@onready var tick_audio: AudioStreamPlayer = $TickAudio


func _ready() -> void:
	back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))
	profile_button.connect("pressed", Callable(func(): tab_container.set_current_tab(0)))
	video_button.connect("pressed", Callable(func(): tab_container.set_current_tab(1)))
	audio_button.connect("pressed", Callable(func(): tab_container.set_current_tab(2)))
	language_button.connect("pressed", Callable(func(): tab_container.set_current_tab(3)))
	controls_button.connect("pressed", Callable(func(): tab_container.set_current_tab(4)))
	# TODO: Make button scene that plays audio
	back_button.connect("mouse_entered", Callable(func(): tick_audio.play()))
	profile_button.connect("focus_entered", Callable(func(): tick_audio.play()))
	video_button.connect("focus_entered", Callable(func(): tick_audio.play()))
	audio_button.connect("focus_entered", Callable(func(): tick_audio.play()))
	language_button.connect("focus_entered", Callable(func(): tick_audio.play()))
	controls_button.connect("focus_entered", Callable(func(): tick_audio.play()))
	# Hover sfx
	back_button.connect("mouse_entered", Callable(func(): tick_audio.play()))
	profile_button.connect("mouse_entered", Callable(func(): tick_audio.play()))
	video_button.connect("mouse_entered", Callable(func(): tick_audio.play()))
	audio_button.connect("mouse_entered", Callable(func(): tick_audio.play()))
	language_button.connect("mouse_entered", Callable(func(): tick_audio.play()))
	controls_button.connect("mouse_entered", Callable(func(): tick_audio.play()))
	profile_button.grab_focus()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		close_menu()


func _on_back_button_pressed() -> void:
	back_audio.play()
	await back_audio.finished
	close_menu()


func close_menu() -> void:
	if get_parent() is Control:
		get_parent().resume_button.grab_focus()
	queue_free()
