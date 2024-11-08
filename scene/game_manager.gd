extends Node

var playerHealth = 3

func playerDeath():
	get_tree().reload_current_scene()
	
func playerCollidedEnemy():
	print("colliding")
