extends RigidBody3D

var speed: float = 25
var lifetime: float = 2.0
var gravity: float = 2.5

@onready var window_smash_audio: AudioStreamPlayer = $WindowSmashAudio

func _physics_process(delta: float) -> void:
	var horizontal_velocity: Vector3 = -transform.basis.x * speed
	var vertical_velocity: float = linear_velocity.y
	vertical_velocity -= gravity * delta

	linear_velocity = horizontal_velocity + Vector3(0, vertical_velocity, 0)

	lifetime -= delta
	if lifetime <= 0:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Window"):
		window_smash_audio.play()
