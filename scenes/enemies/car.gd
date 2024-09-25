extends PathFollow2D

var player_near: bool = false

@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D2

func fire():
	$Turret/LeftFire.modulate.a = 1
	$Turret/RightFire.modulate.a = 1
	if $Turret/RayCast2D.is_colliding():
		var collider = $Turret/RayCast2D.get_collider()
		if collider is Player and Globals.player_vulnerable:
			Globals.health -=20
	if $Turret/RayCast2D2.is_colliding():
		var collider = $Turret/RayCast2D.get_collider()
		if collider is Player and Globals.player_vulnerable:
			Globals.health -=20
	var fireTween = create_tween()
	fireTween.set_parallel(true)
	
	fireTween.tween_property($Turret/LeftFire,"modulate:a",0,0.5)
	fireTween.tween_property($Turret/RightFire,"modulate:a",0,0.5)
	fireTween.play()
	


func _process(delta):
	progress_ratio += 0.02 * delta

	var current_rotation = $Turret.rotation
	var target_rotation: float

	if player_near:
		$Turret.look_at(Globals.player_position)
		target_rotation = $Turret.rotation
	else:
		target_rotation = 0.0 
	var rotation_speed = 2
	$Turret.rotation = lerp_angle(current_rotation, target_rotation, rotation_speed * delta)

func _on_notice_area_body_entered(_body):
	player_near = true
	$AnimationPlayer.play("laser_load")


func _on_notice_area_body_exited(_body):
	player_near = false
	$AnimationPlayer.stop(true)
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Turret/RayCast2D/Line2D,"width",0,0.5)
	tween.tween_property($Turret/RayCast2D2/Line2D2,"width",0,0.5)
