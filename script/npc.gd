extends Area2D

@onready var npc: Area2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var level: int
var playDialogue = true

func _on_body_entered(body: Node2D) -> void:
	body.playerState = "talking"
	if level == 0:
		if playDialogue == true:
			DialogueManager.show_dialogue_balloon(load("res://dialogue/dialogue.dialogue"))
			playDialogue = false
			return
	if level == 4:
		if playDialogue == true:
			DialogueManager.show_dialogue_balloon(load("res://dialogue/final.dialogue"))
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
