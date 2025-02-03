extends CharacterBody3D

const BASE_SPEED: float = 15.0
const BOOST_SPEED: float = 25.0
const ACCELERATION: float = 5.0
const LATERAL_SPEED: float = 10.0
const MAX_TILT: float = 45.0
const TILT_SPEED: float = 5.0

var current_speed: float = BASE_SPEED
var newspapers_left: int = 10

@onready var main_music: AudioStreamPlayer = $MainMusicAudio
@onready var newspapers_label: Label = $NewspapersLabel

func _physics_process(delta: float) -> void:
	if not main_music.playing:
		main_music.play()
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	var target_speed = BASE_SPEED
	if Input.is_action_pressed("accelerate"):
		target_speed = BOOST_SPEED
	if Input.is_action_pressed("slow"):
		target_speed = target_speed * 0.5
	current_speed = lerp(current_speed, target_speed, ACCELERATION * delta)
	
	$bikered.rotation.y = 0.0
	
	var lateral: float = 0.0
	if Input.is_action_pressed("turn_right"):
		$bikered.rotation.y = 270
		lateral += 1.0
	if Input.is_action_pressed("turn_left"):
		$bikered.rotation.y = -270
		lateral -= 1.0
	
	var forward: Vector3 = -transform.basis.z.normalized()
	var right: Vector3 = transform.basis.x.normalized()
	var move_vector: Vector3 = forward * current_speed + right * lateral * LATERAL_SPEED
	move_vector.y = velocity.y
	velocity = move_vector
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept"):
		if (newspapers_left > 0):
			throw_newspaper()

func throw_newspaper():
	newspapers_left -= 1
	update_newspapers_label()
	# Preload the Newspaper scene (see next section)
	var newspaper_scene = preload("res://Scenes/Newspaper.tscn")
	var newspaper = newspaper_scene.instantiate()
	# Spawn the newspaper slightly above the player.
	newspaper.global_transform.origin = global_transform.origin + Vector3(0, 2, 0)
	# Add the newspaper to the current scene (assumes Main.tscn is running).
	get_tree().current_scene.add_child(newspaper)
	
func update_newspapers_label():
	if newspapers_label:
		newspapers_label.text = "Newspapers left: %d" % newspapers_left
