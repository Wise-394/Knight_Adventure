extends StaticBody2D

@onready var cannon: StaticBody2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@onready var cannonAmmo = preload("res:///scene/CannonAmmo.tscn")

func _on_timer_timeout() -> void:
	animated_sprite_2d.play("shoot")

func shoot():
	var new_CannonAmmo = cannonAmmo.instantiate()
	get_tree().current_scene.add_child(new_CannonAmmo)
	new_CannonAmmo.global_position.x = cannon.global_position.x
	new_CannonAmmo.global_position.y = cannon.global_position.y + 3


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "shoot":
		shoot()
		animated_sprite_2d.play("idle")
