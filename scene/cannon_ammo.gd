extends Area2D

var direction = -1
var speed = 100
@onready var cannon_ammo: Area2D = $"."
var state = "Cannon"
@onready var cannonExplosion = preload("res:///scene/cannon_explosion.tscn")
func _process(delta: float) -> void:
	position.x += direction * speed * delta

func explode():
	queue_free() 
	var new_cannonExplosion = cannonExplosion.instantiate()
	get_tree().current_scene.add_child(new_cannonExplosion)
	new_cannonExplosion.global_position = cannon_ammo.global_position
func _on_timer_timeout() -> void:
	explode()


func _on_body_entered(body: Node2D) -> void:
	explode()
	body.playerCollidedCannon()
