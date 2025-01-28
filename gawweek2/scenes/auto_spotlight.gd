extends SpotLight3D

@export var auto_light: int = 1
@export var auto_light_speed: float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_visible_in_tree():
		if spot_attenuation > auto_light:
			spot_attenuation -= auto_light_speed
	else:
		spot_attenuation = 10
	pass

#func _exit_tree() -> void:
	
