extends BaseDialogueTestScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var baloon = load("res://dialogue/balloon.tscn").instantiate()
	get_tree().current_scene.add_child(baloon)
	baloon.start(resource, title)
