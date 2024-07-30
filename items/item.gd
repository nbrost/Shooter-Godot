extends Area2D

var rotation_speed: int = 4
var laser: String = 'laser'
var grenade: String = 'grenade'
var health: String = 'health'
var available_types = [laser,laser,laser,laser, grenade, health]
var type = available_types[randi()%len(available_types)]

var direction: Vector2
var distance: int = randi_range(150,250)

func _ready():
	if type == laser:
		$Sprite2D.modulate = Color(0.1,0.1,0.8,1)
	if type == health:
		$Sprite2D.modulate = Color(0.1,0.8,0.1,1)
	if type == grenade:
		$Sprite2D.modulate = Color(0.8,0.1,0.1,1)
		
	var target_position = position + direction * distance
	print("direction ", direction, " distance ", distance, "target_position ", target_position )
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_position, 0.3)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2(0,0))

func _process(delta):
	rotation += rotation_speed * delta



func _on_body_entered(body):
	if body.has_method("add_item"):
		body.add_item(type)
	queue_free()
