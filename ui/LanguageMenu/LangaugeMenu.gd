extends Control


@onready var list: ItemList = $VBoxContainer/ItemList
@onready var label: Label = $VBoxContainer/SelectedLocale
@onready var system_locale_label: Label = $VBoxContainer/SystemLocale
@onready var empty_label: Label = $EmptyLabel


func _ready() -> void:
	system_locale_label.text += OS.get_locale_language()
	label.text += TranslationServer.get_locale_name(TranslationServer.get_locale())
	if len(TranslationServer.get_loaded_locales()) == 0:
		list.hide()
		empty_label.show()
		return
	for i in TranslationServer.get_loaded_locales():
		list.add_item(i)
	
