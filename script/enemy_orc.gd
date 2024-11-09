extends Enemy

func _ready():
	animated_sprite = $AnimatedSprite2D
	ray_cast_right = $RayCastRight
	ray_cast_left = $RayCastLeft
	timer = $Timer
	game_manager = %GameManager
	ray_cast_left.set_collide_with_areas(true)
	ray_cast_right.set_collide_with_areas(true)
