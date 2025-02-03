extends RigidBody3D
func set_velocity(vel: Vector3) -> void:
	linear_velocity = vel

func _physics_process(delta: float) -> void:
	# Optionally, you could implement additional logic such as self-destruction after a while.
	pass
