extends Area2D

@onready var gameManager = %GameManager
@onready var check_point: Area2D = $"."

func updateCheckPoint():
	gameManager.playerSpawnX = check_point.global_position.x
	gameManager.playerSpawnY = check_point.global_position.y - 20
	print(check_point.global_position.x, check_point.global_position.y)

func _on_body_entered(_body: Node2D) -> void:
	updateCheckPoint()
