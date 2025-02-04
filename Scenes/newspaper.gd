extends RigidBody3D

var speed: float = 25
var lifetime: float = 4.0
var gravity: float = 2.5

const CUSTOMER_WINDOW_POINTS: int = 10
const NON_CUSTOMER_WINDOW_POINTS: int = 50
const CUSTOMER_DOOR_POINTS: int = 150
const CUSTOMER_MAILBOX_POINTS: int = 250

@onready var window_smash_audio: AudioStreamPlayer3D = $WindowSmashAudio

func _physics_process(delta: float) -> void:
	var horizontal_velocity: Vector3 = -transform.basis.x * speed
	var vertical_velocity: float = linear_velocity.y
	vertical_velocity -= gravity * delta

	linear_velocity = horizontal_velocity + Vector3(0, vertical_velocity, 0)

	lifetime -= delta
	if lifetime <= 0:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("CustomerWindow"):
		window_smash_audio.play()
		ScoreManager.add_points(CUSTOMER_WINDOW_POINTS)
	if body.is_in_group("NonCustomerWindow"):
		window_smash_audio.play()
		ScoreManager.add_points(NON_CUSTOMER_WINDOW_POINTS)
	if body.is_in_group("CustomerDoor"):
		ScoreManager.add_points(CUSTOMER_DOOR_POINTS)
