extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var timer = $Timer


const speed = 10
var direction = 1
var stopMoving = false

func _ready():
	ray_cast_left.set_collide_with_areas(true)
	ray_cast_right.set_collide_with_areas(true)
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#check which way to turn
	if ray_cast_right.is_colliding() and not stopMoving:
		direction = -1
		position.x += direction * speed * delta
		stopMoving = true
		timer.start()
		print("stopMoving raycast right", stopMoving)
	elif ray_cast_left.is_colliding() and not stopMoving:
		direction = 1
		position.x += direction * speed * delta
		stopMoving = true
		timer.start()
		print("stopMoving raycast left", stopMoving)
	
	if not stopMoving:
		position.x += direction * speed * delta
	
	# to flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	move_and_slide()


func _on_timer_timeout():
	if stopMoving:
		stopMoving = false # Replace with function body.
