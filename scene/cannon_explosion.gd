extends Area2D


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
	
	


func _on_body_entered(body: Node2D) -> void:
	body.playerGotHit(1000,500)
