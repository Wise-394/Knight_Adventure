extends Node

@export var hearts : Array[Node]
var playerHealth = 3

func playerDeath():
	if get_tree():
		get_tree().call_deferred("reload_current_scene")

func decreasePlayerHealth(amount):
	playerHealth -= amount
	checkHealth()
	
func checkHealth():
	for h in 3:
		if (h < playerHealth):
			hearts[h].show()
		else:
			hearts[h].hide()
	if playerHealth <= 0:
		playerDeath()
