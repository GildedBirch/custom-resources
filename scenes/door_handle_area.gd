extends Area3D

signal touched(ray: RayCast3D)

func interact(ray: RayCast3D):
	touched.emit(ray)
