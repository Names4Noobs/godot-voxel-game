extends Node

var items: Array[Item]
var selected_slot = 1:
	get: return selected_slot
	set(v):
		selected_slot = clamp(v, 1, MAX_SLOTS)
const MAX_SLOTS = 9

func _ready() -> void:
	for i in MAX_SLOTS:
		var item = BlockItem.new(i+1)
		add_child(item)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("scroll_up"):
		get_parent().selected_slot += 1
	elif Input.is_action_just_released("scroll_down"):
		get_parent().selected_slot -= 1
	elif Input.is_action_just_pressed("select_slot1"):
		get_parent().selected_slot = 1
	elif Input.is_action_just_pressed("select_slot2"):
		get_parent().selected_slot = 2
	elif Input.is_action_just_pressed("select_slot3"):
		get_parent().selected_slot = 3
	elif Input.is_action_just_pressed("select_slot4"):
		get_parent().selected_slot = 4
	elif Input.is_action_just_pressed("select_slot5"):
		get_parent().selected_slot = 5
	elif Input.is_action_just_pressed("select_slot6"):
		get_parent().selected_slot = 6
	elif Input.is_action_just_pressed("select_slot7"):
		get_parent().selected_slot = 7
	elif Input.is_action_just_pressed("select_slot8"):
		get_parent().selected_slot = 8
	elif Input.is_action_just_pressed("select_slot9"):
		get_parent().selected_slot = 9

func get_selected_item() -> Item:
	return get_child(0)
