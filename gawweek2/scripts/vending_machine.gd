extends Node3D

@export var player: CharacterBody3D
@export var memory_ring: Node3D

signal vend

var vend_distance = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(position.distance_to(player.position) < vend_distance):
		%OutlineMesh.show()
	else:
		%OutlineMesh.hide()
	pass

func _on_interact():
	if(position.distance_to(player.position) < vend_distance):
		#emit_signal("vend")
		pass

func _on_forget() -> void:
	$AnimationPlayer2.play("interact")
	emit_signal("vend")
