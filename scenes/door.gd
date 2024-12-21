extends Node3D
class_name Door

var held: bool = false
var ray_cast: RayCast3D
var handle_pos: Vector3
var hande_distance: float

@export var reach_limit: float = 3.0

func _ready() -> void:
	%DoorHandleArea.touched.connect(interact)
	handle_pos = %Handle.global_position

func _process(_delta: float) -> void:
	if held and ray_cast:
		%Handle.global_position = ray_cast.global_transform * (Vector3.FORWARD * hande_distance)
		var dir: Vector3 = (%Hinge.global_position - %Handle.global_position).normalized()
		var angle: float = atan2(dir.x, dir.z)
		#Check if player is too far away
		if ray_cast.global_position.distance_to(%Hinge.global_position) > reach_limit:
			cancel_interact()
		#Limit angle
		if angle < -3.0 or angle > 0.0: return
		%Hinge.rotation.y = angle + deg_to_rad(90)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("interact"):
		cancel_interact()

func cancel_interact():
	held = false
	ray_cast = null
	handle_pos = %DoorHandleArea.global_position
	%Handle.global_position = handle_pos

func interact(ray: RayCast3D):
	held = true
	ray_cast = ray
	hande_distance = ray_cast.global_position.distance_to(%Handle.global_position)
