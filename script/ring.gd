extends Area2D


func _on_body_entered(body: Node2D) -> void:
	body.playerState = "talking"
	DialogueManager.show_dialogue_balloon(load("res://dialogue/last.dialogue"))
	queue_free()
	return


func _on_body_exited(body: Node2D) -> void:
	pass
