extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var can_take_damage = true
var left_laser: bool = true 
var health: int = 30

signal laser(posi, direction)

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_position)
		if can_laser:
			var dir: Vector2
			var pos = get_barrel_position()
			dir = (Globals.player_position - pos).normalized()
			laser.emit(pos, dir)
			can_laser = false
			$Timers/LaserCooldown.start()

func hit():
	if can_take_damage:
		$Sprite2D.material.set_shader_parameter("progress", 1)
		can_take_damage = false
		$Timers/InvulnerableTimer.start()
		health -= 10
		print("remaining health " + str(health))
		if health <= 0:
			$".".queue_free()
	
func _on_attach_area_body_entered(_body):
	player_nearby = true

func _on_attach_area_body_exited(_body):
	player_nearby = false

func get_barrel_position():
	if left_laser: 
		left_laser = false
		return $LaserSpawnPositions/LeftLaser.global_position
	left_laser = !left_laser
	return $LaserSpawnPositions/RightLaser.global_position

func _on_laser_cooldown_timeout():
	can_laser = true

func _on_invulnerable_timer_timeout() -> void:
	can_take_damage = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
