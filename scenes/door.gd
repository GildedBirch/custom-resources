extends Node3D
class_name Door

var held: bool = false
var ray_cast: RayCast3D
var handle_pos: Vector3

func _ready() -> void:
	%DoorHandleArea.touched.connect(interact)
	handle_pos = %Handle.global_position

func _process(_delta: float) -> void:
	if held and ray_cast:
		%Handle.global_position = ray_cast.global_transform * (Vector3.FORWARD * 2.0)
		%Hinge.look_at(%Handle.global_position)
		%Hinge.rotation = Vector3(0, %Hinge.rotation.y + deg_to_rad(90), 0)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("interact"):
		held = false
		ray_cast = null
		handle_pos = %DoorHandleArea.global_position
		%Handle.global_position = handle_pos

func interact(ray: RayCast3D):
	held = true
	ray_cast = ray
	print(ray)
