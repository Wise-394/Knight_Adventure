extends StaticBody2D

@onready var cannon: StaticBody2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var side: String

@onready var cannonAmmo = preload("res:///scene/CannonAmmo.tscn")

func _on_timer_timeout() -> void:
	animated_sprite_2d.play("shoot")

func shoot():
	var new_CannonAmmo = cannonAmmo.instantiate()
	get_tree().current_scene.add_child(new_CannonAmmo)
	new_CannonAmmo.side = side
	new_CannonAmmo.shootDirection()
	if side == "left" or side == "right":
		new_CannonAmmo.global_position.x = cannon.global_position.x
		new_CannonAmmo.global_position.y = cannon.global_position.y + 3
	if side == "down" or side == "up":
		new_CannonAmmo.global_position.x = cannon.global_position.x + 3
		new_CannonAmmo.global_position.y = cannon.global_position.y 

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "shoot":
		shoot()
		animated_sprite_2d.play("idle")
