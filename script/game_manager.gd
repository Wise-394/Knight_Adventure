extends Node

@export var hearts : Array[Node]
@onready var coinAmount = %CointAmount
@onready var player: CharacterBody2D = %Player
@onready var arrow_amount: Label = %arrowAmount


var playerHealth = 3
var coins = 0
var arrowAmount = 0
var playerSpawnX = 98
var playerSpawnY = -182

func _ready():
	coinAmount.text = str(coins)
	updateArrowAmount()
	

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
func enemyHit(dmg,enemy):
	enemy.hurt(dmg)
	
func pickUp(item):
	if item == "coin":
		coins +=1
		coinAmount.text = str(coins)
	if item == "heart":
		if playerHealth < 3:
			playerHealth += 1
			checkHealth()
			
func updateArrowAmount():
	arrowAmount = player.arrowAmount
	arrow_amount.text = str(arrowAmount)
	
func playerHitProjectile():
	player.knockback()
	player.playerState = "is_hurt"
	decreasePlayerHealth(1)

func respawnCheckPoint():
	decreasePlayerHealth(1)
	player.position.x = playerSpawnX
	player.position.y = playerSpawnY
