extends Area2D

@export var levelToTp:int
@onready var game_manager: Node = %GameManager

func nextLevel():
	if levelToTp == 2:
		game_manager.savePlayerData()
		get_tree().change_scene_to_file("res://scene/levels/level_2.tscn")

func _on_body_entered(_body: Node2D) -> void:
	call_deferred("nextLevel")
	
	
