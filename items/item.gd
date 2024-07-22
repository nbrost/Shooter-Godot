extends Area2D

var rotation_speed: int = 4
var laser: String = 'laser'
var grenade: String = 'grenade'
var health: String = 'health'
var available_types = [laser,laser,laser,laser, grenade, health]
var type = available_types[randi()%len(available_types)]

func _process(delta):
	rotation += rotation_speed * delta
	if type == laser:
		$Sprite2D.modulate = Color(0.1,0.1,0.8,1)
	if type == health:
		$Sprite2D.modulate = Color(0.1,0.8,0.1,1)
	if type == grenade:
		$Sprite2D.modulate = Color(0.8,0.1,0.1,1)


func _on_body_entered(body):
	body.add_item(type)
	queue_free()
