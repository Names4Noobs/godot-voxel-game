class_name ItemData
extends Resource
@icon("res://assets/textures/item/gold_ingot.png")

const DEFAULT_ITEM_NAME := "Default Item"
const DEFAULT_STACK_SIZE := 64
const DEFAULT_TEXTURE := preload("res://assets/textures/block/default_texture.png")

@export var name := DEFAULT_ITEM_NAME
@export var texture: Texture2D = DEFAULT_TEXTURE
@export var max_stack_size := DEFAULT_STACK_SIZE
