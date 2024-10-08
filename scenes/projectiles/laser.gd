extends Area2D

@export var speed: int = 1000
@export var direction = Vector2(0,0)

func _ready():
	$SelfDestructTimer.start()

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	print(body)
	queue_free()



func _on_self_destruct_timer_timeout():
	queue_free()
