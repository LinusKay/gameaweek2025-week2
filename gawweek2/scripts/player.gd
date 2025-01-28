extends CharacterBody3D

signal jump
signal interact

var speed
const WALK_SPEED = 4.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.002

#bob variables
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

# FOV variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5
var fov_lock = false

# Camera variables
const CAMERA_LIMIT_DOWN = -60
const CAMERA_LIMIT_UP = 80

@export var can_move = true

@onready var head = $Head
@onready var camera = $Head/Camera3D



func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(CAMERA_LIMIT_DOWN), deg_to_rad(CAMERA_LIMIT_UP))


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and can_move:
		velocity.y = JUMP_VELOCITY
		
	# Handle Sprint
	if Input.is_action_pressed("sprint") and can_move:
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Quit game on ESC
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

	if Input.is_action_just_pressed("interact"):
		emit_signal("interact")
		
	if Input.is_action_just_pressed("toggle_mouse_capture"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	if !can_move: input_dir = Vector2.ZERO
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2.0)
		
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	# FOV
	if(!fov_lock):
		var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
		var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
		camera.fov = lerp(camera.fov, target_fov, delta * 8.0)

	move_and_slide()


func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	
