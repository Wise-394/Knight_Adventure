extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var gameManager = %GameManager
@onready var sword_hit = $SwordHit

var health = 3
const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var playerState = "default"
var direction = 0
var knockBackStrength =500
var enemyOnHitBox = false
var enemy = null
var hitRegistered = false
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	move()
	animation()
	playerAttack()
	
func move():
	direction = Input.get_axis("left", "right")
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
	if playerState == "is_hurt":
		animated_sprite.play("hurt")
	elif Input.is_action_just_pressed("lmb") and playerState == "default":
		animated_sprite.play("sword_attack")
		playerState = "sword_attack"
	elif Input.is_action_just_pressed("rmb") and not playerState == "sword_attack":
		animated_sprite.play("bow_attack")
		playerState = "bow_attack"
	elif direction == 0 and not playerState == "sword_attack" and not playerState == "bow_attack":
		animated_sprite.play("idle")
	elif direction != 0 and not playerState == "sword_attack" and not playerState == "bow_attack":
		animated_sprite.play("run")

func playerAttack():
	if animated_sprite.flip_h == false:
		sword_hit.position.x = 7
	else:
		sword_hit.position.x = -19
	
	if playerState == "sword_attack" and enemyOnHitBox and not hitRegistered:
		gameManager.enemyHit(1,enemy)
		hitRegistered = true
		

func playerCollidedEnemy():
	knockBack()
	playerState = "is_hurt"
	gameManager.decreasePlayerHealth(1)

func knockBack():
	velocity.y = JUMP_VELOCITY * 0.5
	if direction >= 0:
		velocity.x = knockBackStrength * -1
	if direction < 0:
		velocity.x = knockBackStrength * 1
	
func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "sword_attack":
		playerState = "default"
		hitRegistered = false
	if animated_sprite.animation == "bow_attack":
		playerState = "default"
	if animated_sprite.animation == "hurt":
		playerState = "default"


func _on_hit_box_body_entered(_body):
	playerCollidedEnemy()
	

func _on_sword_hit_body_exited(_body):
	enemyOnHitBox = false
	enemy = null
func _on_sword_hit_body_entered(body):
	enemyOnHitBox = true
	enemy = body