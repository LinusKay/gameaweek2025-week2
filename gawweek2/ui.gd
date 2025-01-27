extends Control
class_name UI

@export var player: CharacterBody3D

@onready var hp_label = %HP
@onready var memory_container = %MemoryContainer
@onready var memory_description_label = %DescriptionLabel

var label_theme = load("res://ui.tres")

var memory_selected = 0:
	set(new_memory_selected):
		memory_selected = new_memory_selected
		_update_memory_selection()

var hp = 100:
	set(new_hp):
		hp = new_hp
		_update_hp_label()
		
func _update_memory_selection():
	var memory_description = player.memories[player.memory_bank[memory_selected]].description
	memory_description_label.text = memory_description
	for memorylabel_index in memory_container.get_child_count():
		var memorylabel = memory_container.get_child(memorylabel_index)
		if memorylabel_index == memory_selected:
			memorylabel.set("theme_override_colors/font_color", Color(1.0,0.0,0.0,1.0))
		else: 
			memorylabel.set("theme_override_colors/font_color", Color(1.0,1.0,1.0,1.0))


func _process(delta: float) -> void:
	pass
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_hp_label()
	for memory_index in player.memory_bank.size():
		if(memory_index < player.memory_limit):
			var memory_label = Label.new()
			var memory_name = player.memories[player.memory_bank[memory_index]].name
			memory_label.text = memory_name
			memory_label.set("theme", label_theme)
			#memory_label.set("theme_override_fonts/font", load("res://fonts/YujiSyuku/YujiSyuku-Regular.ttf"))
			#memory_label.set("theme_override_font_sizes/font_size", 25)
			memory_container.add_child(memory_label)


func _update_hp_label():
	hp_label.text = str(hp)


func _on_jump():
	hp -= 25


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("menu_memory"):
		if(is_visible_in_tree()): 
			hide()
			player.can_move = true
		else: 
			show()
			player.can_move = false
			
	if is_visible_in_tree():
		if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("wheel_down"):
			if(memory_selected - 1 < 0):
				memory_selected = player.memory_limit - 2
			else:
				memory_selected -= 1
			print(memory_selected)
		if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("wheel_up"):
			if(memory_selected + 1 > player.memory_limit - 2):
				memory_selected = 0
			else:
				memory_selected += 1
			print(memory_selected)
		
