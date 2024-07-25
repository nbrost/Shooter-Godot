extends Area2D

var rotation_speed: int = 4
var laser: String = 'laser'
var grenade: String = 'grenade'
var health: String = 'health'
var available_types = [laser,laser,laser,laser, grenade, health]
var type = available_types[randi()%len(available_types)]

func _ready():
	# Disable the collision shape initially
	$CollisionShape2D.disabled = true
	# Set a timer to enable collision shape after a short delay
	await get_tree().create_timer(1).timeout
	$CollisionShape2D.disabled = false

func _process(delta):
	rotation += rotation_speed * delta
	if type == laser:
		$Sprite2D.modulate = Color(0.1,0.1,0.8,1)
	if type == health:
		$Sprite2D.modulate = Color(0.1,0.8,0.1,1)
	if type == grenade:
		$Sprite2D.modulate = Color(0.8,0.1,0.1,1)


func _on_body_entered(body):
	if body.has_method("add_item"):
		body.add_item(type)
	queue_free()
