extends Area2D

var xDirection = -1
var yDirection = 0
var speed = 100
var side
@onready var cannon_ammo: Area2D = $"."
@onready var wind_trail_timer: Timer = $WindTrailTimer

var state = "Cannon"
@onready var cannonExplosion = preload("res:///scene/cannon_explosion.tscn")
var windTrailSpawn = true
@onready var windTrail = preload("res://scene/wind_trail.tscn")

func _process(delta: float) -> void:
	if side == "left" or side == "right":
		position.x += xDirection * speed * delta
	elif side == "up" or side == "down":
		position.y += yDirection * speed * delta
	if windTrailSpawn:	
		var new_windTrail = windTrail.instantiate()
		get_tree().current_scene.add_child(new_windTrail)
		windTrailSpawn = false
		wind_trail_timer.start()
		if side == "down":
			new_windTrail.position.x = cannon_ammo.position.x + 3
			new_windTrail.position.y = cannon_ammo.position.y - 5
			new_windTrail.rotation = deg_to_rad(90)
		elif side == "left":
			new_windTrail.position.x = cannon_ammo.position.x + 3
			new_windTrail.position.y = cannon_ammo.position.y + 3
		
		
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


func _on_wind_trail_timer_timeout() -> void:
	windTrailSpawn = true
