extends Control
class_name UI

@export var memory_ring: Node3D
@export var player: CharacterBody3D
@export var juicedupui: Control

@onready var memory_count_label = %MemoryCountLabel
@onready var memory_container = %MemoryContainer
@onready var memory_description_label = %DescriptionLabel

var label_theme = load("res://textures/ui.tres")

var memory_count = 0:
	set(new_memory_count):
		memory_count = new_memory_count
		_update_memory_count_label()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_selection_change()
	_update_memory_count_label()
	

func _process(delta: float) -> void:
	pass


func juiceup() -> void:
	juicedupui.juiceup()


func _update_memory_count_label():
	memory_count_label.text = str(memory_count)


func _on_selection_change():
	%NameLabel.text = memory_ring.get_memory_name()
	%MessageLabel.text = memory_ring.get_memory_description()

func show_instruction():
	%InstructionLabel.show()
	
func hide_instruction():
	%InstructionLabel.hide()
