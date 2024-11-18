extends Area2D


@onready var sprite: Sprite2D = $sprite

const speed = 250
var state = "shoot"
var direction = 1
func _process(delta: float) -> void:
	move(delta)

func move(delta):
	if state == "shoot":
		position.x += direction * speed * delta

func _on_area_entered(_area: Area2D) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.hurt(3)
		queue_free()
	state = "dead"
	print("collision")


func _on_timer_timeout() -> void:
	queue_free()
