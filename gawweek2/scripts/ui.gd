extends Control
class_name UI

@export var memory_ring: Node3D
@export var player: CharacterBody3D

@onready var hp_label = %HP
@onready var memory_container = %MemoryContainer
@onready var memory_description_label = %DescriptionLabel

var label_theme = load("res://textures/ui.tres")

var hp = 100:
	set(new_hp):
		hp = new_hp
		_update_hp_label()
		
func _update_memory_selection():
	pass
	#var memory_description = memory_ring.memories[memory_ring.memory_bank[memory_selected]].description
	#memory_description_label.text = memory_description
	#for memorylabel_index in memory_container.get_child_count():
		#var memorylabel = memory_container.get_child(memorylabel_index)
		#if memorylabel_index == memory_selected:
			#memorylabel.set("theme_override_colors/font_color", Color(1.0,0.0,0.0,1.0))
		#else: 
			#memorylabel.set("theme_override_colors/font_color", Color(1.0,1.0,1.0,1.0))


func _process(delta: float) -> void:
	pass
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_hp_label()
	

func _update_hp_label():
	hp_label.text = str(hp)


func _on_jump():
	hp -= 25

func _on_selection_change():
	print("UI: selection change")
	%DescriptionLabel.text = memory_ring.get_memory_name()

		
