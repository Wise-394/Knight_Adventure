extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var gameManager = %GameManager
@onready var timer = $HurtTimer

var health = 3
const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var isAttackingSword = false
var isAttackingBow = false
var isHurt = false
var direction = 0
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("left", "right")
	move()
	animation()
	
func move():
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	#move the sprite depends on direction
	if direction:
		velocity.x = direction * SPEED
	elif direction <= 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func animation():
	if isHurt:
		animated_sprite.play("hurt")
	elif Input.is_action_just_pressed("lmb") and isAttackingBow == false:
		animated_sprite.play("sword_attack")
		isAttackingSword = true
	elif Input.is_action_just_pressed("rmb") and isAttackingSword == false:
		animated_sprite.play("bow_attack")
		isAttackingBow = true
	elif direction == 0 and not isAttackingSword and not isAttackingBow:
		animated_sprite.play("idle")
	elif direction != 0 and not isAttackingSword and not isAttackingBow:
		animated_sprite.play("run")

func playerCollidedEnemy():
	isHurt = true
	timer.start()
	knockBack()
	gameManager.decreasePlayerHealth(1)

func knockBack():
	velocity.y = JUMP_VELOCITY * 0.5
func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "sword_attack":
		isAttackingSword = false
	if animated_sprite.animation == "bow_attack":
		isAttackingBow = false


func _on_hit_box_body_entered(body):
	playerCollidedEnemy()


func _on_timer_timeout():
	if isHurt:
		isHurt = false
