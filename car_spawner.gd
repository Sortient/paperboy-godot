# car_spawner.gd
extends Node3D

# Preload your Car scene.
var car_scene = preload("res://Scenes/Car01.tscn")
var spawn_interval: float = 2.0

func _ready() -> void:
	# Create and configure a Timer.
	var timer: Timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)
	timer.connect("timeout", Callable(self, "spawn_car"))

func spawn_car() -> void:
	var car = car_scene.instantiate()
	
	# Position the car at the top of the road.
	# Adjust the position as needed based on your level design.
	# Here, we assume the road's top is along positive Z, e.g., at (0, 0, 20).
	car.global_transform.origin = Vector3(0, 0, 50)
	
	# Determine the driving direction.
	# For example, if your player's forward is -Z, then driving the car in the opposite direction means -Z.
	# However, if the car is spawned at the top of the road, you might want it to drive downward (i.e. -Z).
	# Adjust the speed as needed.
	var car_speed: float = -5.0
	# Here we set the car's velocity to move along the negative Z axis.
	if car.has_method("set_velocity"):
		car.set_velocity(Vector3(0, 0, -car_speed))
	else:
		# If no method exists, assume a RigidBody3D and set linear_velocity.
		car.linear_velocity = Vector3(0, 0, -car_speed)
	
	# Add the car to the active scene.
	get_tree().current_scene.add_child(car)
