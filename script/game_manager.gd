extends Node

@export var hearts : Array[Node]
@onready var coinAmount = %CointAmount
@onready var player: CharacterBody2D = %Player
@onready var arrow_amount: Label = %arrowAmount
@onready var coin: AudioStreamPlayer = $coin

@export var currentLevel: int
var saveData = PlayerData.new()

var playerHealth = 3
var coins:int
var arrowAmount = 3
var playerSpawnX = 98
var playerSpawnY = -182
var coinFX
func _ready():
	coinFX = preload("res://scene/coin_fx.tscn")
	if currentLevel == 1:
		coins = 0
		coinAmount.text = str(coins)
		arrowAmount = 3
	elif currentLevel == 2:
		load_data()
	elif currentLevel == 3:
		load_data()
	updateArrowAmount()
	

func playerDeath():
	if get_tree():
		arrowAmount = 3
		coins = 0
		savePlayerData()
		updateArrowAmount()
		get_tree().call_deferred("reload_current_scene")

func decreasePlayerHealth(amount):
	playerHealth -= amount
	checkHealth()
func increasePlayerHealth(amount):
	playerHealth += amount
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
		var new_coin = coinFX.instantiate()
		get_tree().current_scene.add_child(new_coin)
		new_coin.global_position.x = player.global_position.x
		new_coin.global_position.y = player.global_position.y - 12
		coinAmount.text = str(coins)
		coin.play()
	if item == "heart":
		if playerHealth < 3:
			playerHealth += 1
			checkHealth()
func decreaseCoin(amount):
	coins -= amount
	coinAmount.text = str(coins)			
func updateArrowAmount():
	player.arrowAmount = arrowAmount
	arrow_amount.text = str(arrowAmount)
func increaseArrowAmount(quantity):
	arrowAmount += quantity
	updateArrowAmount()
func playerHitProjectile():
	player.knockback()
	player.playerState = "is_hurt"
	decreasePlayerHealth(1)

func respawnCheckPoint():
	decreasePlayerHealth(1)
	player.position.x = playerSpawnX
	player.position.y = playerSpawnY

func savePlayerData():
	saveData.coins = coins
	saveData.arrow = arrowAmount
	var _result = ResourceSaver.save(saveData,"user://save_game.tres")

func load_data():
	if ResourceLoader.exists("user://save_game.tres"):
		var playerData = ResourceLoader.load("user://save_game.tres") as PlayerData
		if playerData:
			coins = playerData.coins
			arrowAmount = playerData.arrow
			coinAmount.text = str(coins)
		
