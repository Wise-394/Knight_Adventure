extends TextureButton

@onready var shop: Control = $Shop
var visibility = false
@export var player: Node2D


func hideShop():
	shop.visible = false
	visibility = false
	get_tree().paused = false
	player.playerState = "default"



func _on_pressed() -> void:
	if visibility == false:
		player.playerState = "pause"
		shop.visible = true
		visibility = true
		get_tree().paused = true
	else:
		hideShop()
	
	
