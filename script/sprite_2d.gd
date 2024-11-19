extends Sprite2D

@onready var sprite_2d: Sprite2D = $"."

@export var speed = 0

func _process(delta: float) -> void:
	sprite_2d.position.x -= speed * delta
	if sprite_2d.position.x <= -30:
		sprite_2d.position.x = 220
