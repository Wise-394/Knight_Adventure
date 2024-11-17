extends CharacterBody2D

class_name Enemy
var animated_sprite
var ray_cast_right
var ray_cast_left
var timer
var game_manager
var area_2d
var hp
var state = "default"

const speed = 10
var direction = 1
var stopMoving = false
var JUMP_VELOCITY = -150

func _ready():
	add_to_group("enemy")

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#check which way to turn
	if ray_cast_right.is_colliding() and not stopMoving:
		stopMoving = true
		direction = -1
		position.x += direction * speed * delta
		timer.start()
	elif ray_cast_left.is_colliding() and not stopMoving:
		stopMoving = true
		direction = 1
		position.x += direction * speed * delta
		timer.start()
	if not stopMoving:
		position.x += direction * speed * delta
	
	move_and_slide()
	faceDirection()

func faceDirection():
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true


func _on_timer_timeout():
	if stopMoving:
		stopMoving = false # Replace with function body.
		
func hurt(dmg):
	hp -= dmg
	knockBack()
	if hp > 0:
		animated_sprite.play("hurt")
		stopMoving = true
		timer.start()
	elif hp <= 0:
		state = "dead"
		death()
func knockBack():
	velocity.y = JUMP_VELOCITY * 0.5
func death():
	stopMoving = true
	animated_sprite.play("death")
	
func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "hurt":
		animated_sprite.play("walk")
		stopMoving = false
	elif animated_sprite.animation == "death":
		queue_free()
