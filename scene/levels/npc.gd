extends Area2D

@onready var npc: Area2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var playDialogue = true

func _on_body_entered(body: Node2D) -> void:
	body.playerState = "talking"
	if playDialogue == true:
		DialogueManager.show_dialogue_balloon(load("res://dialogue.dialogue"))
		playDialogue = false
		return



func _on_body_exited(body: Node2D) -> void:
	body.playerState = "default"
	print(body.position.x, npc.position.x)
	if body.position.x > npc.position.x:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
	playDialogue = true
