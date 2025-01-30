extends Node3D

@export var player: CharacterBody3D
@export var memory_ring: Node3D

@onready var _sfx_drop = preload("res://audio/vending_machine_drop.ogg")

signal vend_memory
signal vend_item
signal request_memory

var vending = false

var vending_items = {
	"memory_1": {name = "memory 1", type="memory"},
	"coga": {name = "coga cola", type="item"},
	"memory_2": {name = "memory 2", type="memory"}
}

var stock = [
	"memory_1",
	"coga",
	"memory_2"
]

var selected_stock = 0:
	set(selected_new):
		selected_stock = selected_new
		_handle_selection()

var vend_distance = 4

func _change_vend() -> void:
	var _vend_text = vending_items[stock[selected_stock]].name
	%Label3D.text = _vend_text
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_change_vend()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(position.distance_to(player.position) < vend_distance):
		%OutlineMesh.show()
		%Label3D.show()
	else:
		%OutlineMesh.hide()
		%Label3D.hide()
	pass

func _on_interact():
	if(position.distance_to(player.position) < vend_distance):
		vending = true
		emit_signal("request_memory")
		pass

func _on_forget() -> void:
	$AnimationPlayer2.play("interact")
	$VendingAudio.stream = _sfx_drop
	$VendingAudio.play()
	var vend_item = vending_items[stock[selected_stock]]
	if(vend_item.type == "memory"):
		memory_ring.add_memory(stock[selected_stock], false)
		emit_signal("vend_memory")
	else: emit_signal("vend_item")
	vending = false


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left") && !memory_ring.is_visible_in_tree():
		selected_stock = _selection_bound(selected_stock - 1, 0, stock.size() - 1)
	if Input.is_action_just_pressed("right")&& !memory_ring.is_visible_in_tree():
		selected_stock = _selection_bound(selected_stock + 1, 0, stock.size())

func _handle_selection():
	var _vend_text = vending_items[stock[selected_stock]].name
	%Label3D.text = _vend_text

func _selection_bound(_selection, _limit_low, _limit_up) -> int:
	if(_selection < _limit_low): _selection = _limit_up - 1
	elif(_selection > (_limit_up - 1)): _selection = _limit_low
	return _selection
