extends Area2D

var xDirection = -1
var yDirection = 0
var speed = 100
var side
@onready var cannon_ammo: Area2D = $"."
var state = "Cannon"
@onready var cannonExplosion = preload("res:///scene/cannon_explosion.tscn")


func _process(delta: float) -> void:
	if side == "left" or side == "right":
		position.x += xDirection * speed * delta
	elif side == "up" or side == "down":
		position.y += yDirection * speed * delta

func explode():
	var new_cannonExplosion = cannonExplosion.instantiate()
	get_tree().current_scene.add_child(new_cannonExplosion)
	new_cannonExplosion.global_position = cannon_ammo.global_position
	queue_free()
func _on_timer_timeout() -> void:
	explode()


func _on_body_entered(_body: Node2D) -> void:
	call_deferred("explode")

func shootDirection():
	if side == "left":
		xDirection = -1
	elif side == "right":
		xDirection = 1
		cannon_ammo.flip_h = true
	elif side == "down":
		yDirection = 1
		cannon_ammo.rotation = deg_to_rad(-90)
	elif side == "up":
		yDirection = -1
		cannon_ammo.rotation = deg_to_rad(-90)
