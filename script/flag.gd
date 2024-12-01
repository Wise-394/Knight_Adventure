extends Area2D

@export var levelToTp:int
@onready var game_manager: Node = %GameManager

func nextLevel():
	if levelToTp == 1:
		get_tree().change_scene_to_file("res://scene/levels/level1.tscn")
	elif levelToTp == 2:
		game_manager.savePlayerData()
		get_tree().change_scene_to_file("res://scene/levels/level_2.tscn")
	elif levelToTp == 3:
		game_manager.savePlayerData()
		get_tree().change_scene_to_file("res://scene/levels/level_3.tscn")
	elif levelToTp == 4:
		get_tree().change_scene_to_file("res://scene/levels/level_4.tscn")
	elif levelToTp == 5:
		get_tree().change_scene_to_file("res://scene/levels/end.tscn")
		
		
func _on_body_entered(_body: Node2D) -> void:
	call_deferred("nextLevel")
	
	
