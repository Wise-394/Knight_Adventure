extends Control

@onready var shop_button: TextureButton = $".."
@onready var quantity_label: Label = $NinePatchRect/Node/QuantityLabel
@onready var life_text_label: Label = $NinePatchRect/LifeBg/BuyLife/LifeTextLabel
@onready var ammo_text_label: Label = $NinePatchRect/LifeBg/ArrowBg/BuyAmmo/AmmoTextLabel
@export var gameManager: Node
var coins
func _ready() -> void:
	quantity_label.text = "1"
	life_text_label.text = "20"
	ammo_text_label.text = "5"
	


func changeQuantity(mode):
	var quantity = int(quantity_label.text)
	if mode == "up" and not quantity == 9:
		quantity += 1
	elif mode == "down" and not quantity == 1:
		quantity -= 1
	quantity_label.text = str(quantity)
	life_text_label.text = str(20 * quantity)
	ammo_text_label.text = str(5 * quantity)

func _on_exit_button_pressed() -> void:
	shop_button.hideShop()


func _on_up_button_pressed() -> void:
	changeQuantity("up")

func _on_down_button_pressed() -> void:
	changeQuantity("down")


func _on_buy_life_pressed() -> void:
	coins = gameManager.coins
	var quantity = int(quantity_label.text)
	var price = int(life_text_label.text)
	if gameManager.playerHealth == 3:
		print("full hp")
	elif coins >= price:
		gameManager.increasePlayerHealth(quantity)
		gameManager.decreaseCoin(price)

func _on_buy_ammo_pressed() -> void:
	coins = gameManager.coins
	var quantity = int(quantity_label.text)
	var price = int(ammo_text_label.text)
	if coins >= price:
		print(true)
		gameManager.increaseArrowAmount(quantity)
		gameManager.decreaseCoin(price)
