extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node) -> void:
	if body is CharacterBody3D and body.has_method("restore_newspapers"):
		body.restore_newspapers()
		queue_free()
