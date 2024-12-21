extends CharacterBody3D
class_name Player

const SPEED = 5.0
#const JUMP_VELOCITY = 4.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_motion := Vector2.ZERO

@export var mouse_sens: float = 0.002

@onready var look_ray: RayCast3D = %LookRay
@onready var camera_pivot: Node3D = %CameraPivot

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	handle_camera_rotation()

	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			mouse_motion = -event.relative * mouse_sens
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("interact"):
		var hit = look_ray.get_collider()
		if hit:
			hit.interact(look_ray)

func handle_camera_rotation() -> void:
	rotate_y(mouse_motion.x)
	camera_pivot.rotate_x(mouse_motion.y)
	camera_pivot.rotation_degrees.x = clampf(camera_pivot.rotation_degrees.x, -90.0, 90.0)
	mouse_motion = Vector2.ZERO
