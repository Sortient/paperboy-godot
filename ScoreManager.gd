extends Node

var score: int = 0
var score_label: Label = null

func _ready() -> void:
	score_label = get_tree().current_scene.get_node("root")
	update_ui()
	
func add_points(points: int) -> void:
	score += points
	update_ui()
	
func update_ui() -> void:
	if score_label:
		score_label.text = "Points: %d" % score
