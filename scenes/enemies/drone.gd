extends CharacterBody2D

var active: bool = false
var vulnerable: bool = true
var speed: int = 0
var speed_multiplier: int = 1
var health: int = 30
var max_speed: int = 1000
var explosion_active: bool = false
var explosion_radius: int = 400

func _ready():
	$Explosion.visible = false

func _process(delta):
	var direction = (Globals.player_position - position).normalized()
	if active:
		look_at(Globals.player_position)
		velocity = direction * speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
				target.hit()

 
func hit():
	if vulnerable:
		$Sprite2D.material.set_shader_parameter("progress", 1)
		vulnerable = false
		$HitTimer.start()
		health -= 10
	if health <= 0:
		$AnimationPlayer.play("explosion")

func stop_movement():
	speed_multiplier = 0

func _on_notice_area_body_entered(_body):
	active = true
	var tween = get_tree().create_tween()
	tween.tween_property($".","speed",max_speed, 4)

func set_explosion_active():
	explosion_active = true

func _on_hit_timer_timeout():
	$Sprite2D.material.set_shader_parameter("progress", 0)
	vulnerable = true
