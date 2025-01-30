extends Node3D

signal selection_changed
signal forget

@export var ui: UI
@export var player: CharacterBody3D

@onready var _sfx_chime1 = preload("res://audio/chime1.ogg")
@onready var _sfx_chime2 = preload("res://audio/chime2.ogg")
@onready var _sfx_chime3 = preload("res://audio/chime3.ogg")


# memory management
@onready var memories = {
	"memory_1": {name = "memory 1", description = "you swam in the creek.\nlight filtered through the canopy like soft rain.", shape = CSGBox3D},
	"memory_2": {name = "memory 2", description = "your mother's eyes were green.", shape = CSGSphere3D},
	"memory_3": {name = "memory 3", description = "blood dripped from your face onto cold tile.\nyour nose never sat right again.", shape = CSGTorus3D},
	"memory_4": {name = "memory 4", description = "sorrow.\nthat inky black welling in the pit of your stomach.", shape = CSGCylinder3D},
	"memory_5": {name = "memory 5", description = "soft sheets. comfort. sleep.", shape = CSGBox3D},
	"memory_6": {name = "memory 6", description = "their fingers felt so fragile, woven with your own", shape = CSGBox3D},
	"memory_7": {name = "memory 7", description = "music drifted gently through the streets, \nmorning fresh with birdsong", shape = CSGCylinder3D},
	"memory_8": {name = "memory 8", description = "you cheered in awe at the lions in their glass enclosures\nthey met you with a low roar", shape = CSGTorus3D},
	"memory_9": {name = "memory 9", description = "the sky painted a milky wash of stars,\nfor two silent visitors, hand-in-hand on the grass.", shape = CSGSphere3D},
}

@onready var memory_bank = [
	#"memory_1",
	#"memory_2",
	#"memory_4",
]

@onready var memory_limit = 4

var readied = false

var memory_selected = 0:
	set(memory_selected_new):
		memory_selected = memory_selected_new
		_handle_memory_select()

var memorybox_scene = preload("res://scenes/memory_box.tscn")
var audio_autokill_scene = preload("res://scenes/audio_stream_player_autokill.tscn")

var rotation_goal = 0.0  
var rotation_speed = 300.0  
var rotating = false  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_memory_setup()
	_memory_box_setup()
	readied = true

func _process(delta: float) -> void:
	if rotating:
		var current_rotation = %MemoryBoxParent.rotation_degrees.y
		var difference = rotation_goal - current_rotation

		# Wrap angle to handle 360-degree bounds
		difference = wrapf(difference, -180, 180)

		# Calculate rotation step
		var step = rotation_speed * delta
		if abs(difference) <= step:
			# If within one step, snap to goal
			%MemoryBoxParent.rotation_degrees.y = rotation_goal
			rotating = false  # Stop rotating
		else:
			# Rotate toward the goal
			var direction = sign(difference)
			%MemoryBoxParent.rotation_degrees.y += direction * step
		

func _memory_setup() -> void:
	var memories_temp = memories.duplicate()
	for n in randi_range(3,5):
		var memory_key = memories_temp.keys()[randi() % memories_temp.size()]
		memory_bank.append(memory_key)
		memories_temp.erase(memory_key)

func _memory_box_setup() -> void:
	memory_selected = 0
	_handle_memory_select()
	# Reset rotation to zero
	rotation_goal = 0.0
	%MemoryBoxParent.rotation_degrees.y = 0.0
	rotating = false  # Stop any ongoing rotation

	# Remove all existing children
	for child in %MemoryBoxParent.get_children():
		child.queue_free()

	# Recreate boxes around the ring
	var memory_bank_count = memory_bank.size()
	if memory_bank_count == 0:
		return

	var rotation_amount = 360.0 / memory_bank_count
	for memory_index in memory_bank_count:
		# Create new instance of memory_box node
		var memory_box_new = memorybox_scene.instantiate()
		memory_box_new.shape = memories[memory_bank[memory_index]].shape
		memory_box_new.rotate_y(deg_to_rad(-rotation_amount * memory_index))
		%MemoryBoxParent.add_child(memory_box_new)

		# Select the first instance by default
		if memory_index == 0:
			memory_box_new.selected = true


func _unhandled_input(event: InputEvent) -> void:
	if is_visible_in_tree():
		if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("wheel_down"):
			memory_selected = _selection_bound(memory_selected - 1, 0, memory_bank.size())
			_rotate_ring(-1)
					
		if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("wheel_up"):
			memory_selected = _selection_bound(memory_selected + 1, 0, memory_bank.size())
			_rotate_ring(+1)
			
	if Input.is_action_just_pressed("test_1"):
		add_memory(memories.keys()[randi() % memories.keys().size()])


func _handle_memory_select() -> void:
	for child in %MemoryBoxParent.get_children():
		if(child.get_index() == memory_selected):
			child.selected = true
		else: 
			child.selected = false
	emit_signal("selection_changed")
	if readied: 
		_play_sfx(_sfx_chime2)


func _rotate_ring(_polarity: int) -> void:
	var step_size = 360.0 / memory_bank.size()
	rotation_goal += step_size * _polarity
	rotation_goal = wrapf(rotation_goal, 0, 360)
	rotating = true  # Start rotating


func _selection_bound(_selection, _limit_low, _limit_up) -> int:
	if(_selection < _limit_low):
		_selection = _limit_up - 1
	elif(_selection > (_limit_up - 1)):
		_selection = _limit_low
	return _selection


# Memory management
func add_memory(_memory_id, _reload = true) -> void:
	memory_bank.append(_memory_id)
	if _reload:
		_memory_box_setup()

func _replace_memory(_index, _memory_id) -> void:
	memory_bank[_index] = _memory_id
	_memory_box_setup()

func delete_memory(_index) -> void:
	memory_bank.remove_at(_index)
	_memory_box_setup()


# Getter functions
func get_memory_name() -> String:
	if(memory_bank.size() > 0):
		return memories[memory_bank[memory_selected]].name
	else: 
		return "no memory"

func get_memory_description() -> String:
	if(memory_bank.size() > 0):
		return memories[memory_bank[memory_selected]].description
	else: 
		return ""
	

func _on_memory_request() -> void:
	if(is_visible_in_tree()): 
		if(memory_bank.size() > 0):
			emit_signal("forget")
			delete_memory(memory_selected)
		if %CloseTimer.is_stopped():
			hide_ring()
			ui.hide_instruction()
	else: 
		if(memory_bank.size() > 0): 
			_play_sfx(_sfx_chime1)
		else: 
			_play_sfx(_sfx_chime3)
			%CloseTimer.start()
		show_ring()
		ui.show_instruction()


func show_ring() -> void:
	show()
	ui.show()
	player.can_move = false
	

func hide_ring() -> void:
	hide()
	ui.hide()
	player.can_move = true
	
	
func _play_sfx(_sfx) -> void:
	var audio_node = audio_autokill_scene.instantiate()
	audio_node.stream = _sfx
	add_child(audio_node)


func _on_close_timer_timeout() -> void:
	if is_visible_in_tree():
		hide()
		ui.hide()
		player.can_move = true
