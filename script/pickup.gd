extends Area2D

class_name Pickup
var gameManager
var type

func _on_body_entered(_body: Node2D) -> void:
	gameManager.pickUp(type)
	queue_free()
