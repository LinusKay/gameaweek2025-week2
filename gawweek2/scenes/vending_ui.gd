extends Control

@export var player: CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func change_vend_label(_text) -> void:
	%VendingLabel.text = _text
	
func show_vend_label() -> void:
	%VendingLabel.show()
	#player.can_move = false
	
func hide_vend_label() -> void:
	%VendingLabel.hide()
	#player.can_move = true
