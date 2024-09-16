extends CharacterBody2D

var player_nearby: bool = false
var speed: int = 300
var can_laser: bool = true
var can_take_damage = true
var active: bool = false
var health: int = 30

signal laser(posi, direction)

func _process(_delta):
	var direction = (Globals.player_position - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()
		look_at(Globals.player_position)

func hit():
	if can_take_damage:
		$Particles/HitParticles.emitting = true
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		can_take_damage = false
		$Timers/InvulnerableTimer.start()
		health -= 10
		print("remaining health " + str(health))
		if health <= 0:
			await get_tree().create_timer(0.5).timeout
			$".".queue_free()

func _on_invulnerable_timer_timeout() -> void:
	
	can_take_damage = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)

func _on_attack_area_body_entered(_body):
	player_nearby = true
	$AnimatedSprite2D.play("attack")

func _on_attack_area_body_exited(_body):
	player_nearby = false

func _on_notice_area_body_entered(_body):
	active = true
	$AnimatedSprite2D.play("walk")
	
func _on_notice_area_body_exited(_body):
	active = false
	$AnimatedSprite2D.stop()


func _on_animated_sprite_2d_animation_finished():
	if player_nearby:
		Globals.health -= 10
		$AnimatedSprite2D.play("attack")
