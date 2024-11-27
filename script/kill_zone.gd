extends Area2D

@onready var timer = $Timer
@onready var game_manager = %GameManager

func _on_body_entered(_body):
	timer.start()


func _on_timer_timeout():
	game_manager.respawnCheckPoint()


	
