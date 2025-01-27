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

@export var can_move = true

# memory management
@onready var memories = {
	"mother_eyes": {name = "mother's eyes"},
	"home_scent": {name = "home's scent"},
	"lover_touch": {name = "lover's touch"},
	"sun_light": {name = "sun's light"},
	"wind_breeze": {name = "wind's breeze"},
}

@onready var memory_bank = [
	"mother_eyes",
	"lover_touch",
	"wind_breeze"
]

@onready var memory_limit = 4


@onready var camera_spring = $SpringArmPivot

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and can_move:
		velocity.y = JUMP_VELOCITY
		emit_signal("jump")
		
	# Handle Sprint
	if Input.is_action_pressed("sprint") and can_move:
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Quit game on ESC
	if Input.is_action_pressed("exit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("interact"):
		emit_signal("interact")
		
		

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	if !can_move: input_dir = Vector2.ZERO
	var direction = (camera_spring.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
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
	

	move_and_slide()
