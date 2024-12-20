extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var gameManager = %GameManager
@onready var sword_hit = $SwordHit
@onready var player: CharacterBody2D = $"."
@onready var timer: Timer = $Timer
@onready var jump: AudioStreamPlayer2D = $sound/jump
@onready var attack: AudioStreamPlayer2D = $sound/attack
@onready var hurt: AudioStreamPlayer2D = $sound/hurt
@onready var shoot_sound: AudioStreamPlayer2D = $sound/shootSound

var arrow
var smoke
var canCreateSmoke = true
const SPEED = 115.0
const JUMP_VELOCITY = -300.0
var playerState = "default"
var direction = 0
var enemyOnHitBox = false
var enemy = null
var hitRegistered = false
var arrowAmount
var playhurt = true

func _ready() -> void:
	arrow = preload("res:///scene/arrow.tscn")
	smoke = preload("res://scene/smoke.tscn")
	arrowAmount = gameManager.arrowAmount
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump.play()

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
	
	
	if canCreateSmoke:
		if velocity.x > 0 and velocity.y == 0:
			var new_smoke = smoke.instantiate()
			get_tree().current_scene.add_child(new_smoke)
			new_smoke.global_position.x = sword_hit.global_position.x - 10
			new_smoke.global_position.y = sword_hit.global_position.y + 2
			canCreateSmoke = false
			timer.start()
		elif velocity.x < 0 and velocity.y == 0: 
			var new_smoke = smoke.instantiate()
			get_tree().current_scene.add_child(new_smoke)
			new_smoke.global_position.x = sword_hit.global_position.x + 20
			new_smoke.global_position.y = sword_hit.global_position.y + 2
			canCreateSmoke = false
			timer.start()
	

func animation():
	if playerState == "is_hurt":
		if playhurt == true:
			hurt.play()
			playhurt = false
		animated_sprite.play("hurt")
	elif Input.is_action_just_pressed("lmb") and playerState == "default":
		animated_sprite.play("sword_attack")
		attack.play()
		playerState = "sword_attack"
	elif Input.is_action_just_pressed("rmb") and not playerState == "sword_attack" and arrowAmount > 0:
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
	if playerState == "bow_attack":
		pass
		
func shoot():
	shoot_sound.play()
	var new_arrow = arrow.instantiate()
	get_tree().current_scene.add_child(new_arrow)
	new_arrow.global_position = sword_hit.global_position
	if animated_sprite.flip_h == false:
		new_arrow.direction = 1
	else:
		new_arrow.sprite.flip_h = true
		new_arrow.direction = -1
	gameManager.arrowAmount -= 1
	gameManager.updateArrowAmount()
		
func playerCollidedEnemy(body):
	if body.state != "dead":
		knockBack(500,300)
		playerState = "is_hurt"
		gameManager.decreasePlayerHealth(1)
func playerGotHit(knockBackDistance,jumpDistance):
	knockBack(knockBackDistance,jumpDistance)
	playerState = "is_hurt"
	gameManager.decreasePlayerHealth(1)
func knockBack(knockbackDistance,jumpDistance):
	velocity.y = jumpDistance * 0.5
	if direction >= 0:
		velocity.x = knockbackDistance * -1
	if direction < 0:
		velocity.x = knockbackDistance * 1
	
func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "sword_attack":
		playerState = "default"
		hitRegistered = false
	if animated_sprite.animation == "bow_attack":
		shoot()
		playerState = "default"
	if animated_sprite.animation == "hurt":
		playerState = "default"
		playhurt = true


func _on_hit_box_body_entered(body):
	playerCollidedEnemy(body)
	

func _on_sword_hit_body_exited(_body):
	enemyOnHitBox = false
	enemy = null
func _on_sword_hit_body_entered(body):
	enemyOnHitBox = true
	enemy = body


func _on_hit_box_body_exited(_body: Node2D) -> void:
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	canCreateSmoke = true
