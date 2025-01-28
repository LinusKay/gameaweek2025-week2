extends Node3D

@export var shape = CSGBox3D

@export var selected = false:
	set(selected_new):
		selected = selected_new
		_handle_selection()

var bob = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var shape_node = shape.new()
	shape_node.scale = Vector3(.25, .25, .25)
	shape_node.position = Vector3(-0.75, 0.399, 0)
	add_child(shape_node)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected:
		bob += delta
		position.y = (sin(bob) + 0) / 10
	pass
	


# Called whenever selected is set
func _handle_selection() -> void: 
	if(selected):
		if !$AnimationPlayer.is_playing():
			$AnimationPlayer.play("spin")
	else:
		$AnimationPlayer.stop()
