extends Control
class_name UI

@export var memory_ring: Node3D
@export var player: CharacterBody3D

@onready var memory_count_label = %MemoryCountLabel
@onready var memory_container = %MemoryContainer
@onready var memory_description_label = %DescriptionLabel

var label_theme = load("res://textures/ui.tres")

var memory_count = 0:
	set(new_memory_count):
		memory_count = new_memory_count
		_update_memory_count_label()

func _process(delta: float) -> void:
	pass
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_memory_count_label()
	

func _update_memory_count_label():
	memory_count_label.text = str(memory_count)

func _on_selection_change():
	print("UI: selection change")
	%DescriptionLabel.text = memory_ring.get_memory_name()

		
