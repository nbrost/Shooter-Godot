extends Area2D

@export var speed: int = 1000
@export var direction = Vector2(0,0)

func _process(delta):
	
	position += direction * speed * delta
