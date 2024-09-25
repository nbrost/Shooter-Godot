extends PathFollow2D

var player_near: bool = false

@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D2

func _ready():
	pass


func fire():
	if $Turret/RayCast2D.is_colliding():
		var collider = $Turret/RayCast2D.get_collider()
		if collider is Player and Globals.player_vulnerable:
			Globals.health -=20
	if $Turret/RayCast2D2.is_colliding():
		var collider = $Turret/RayCast2D.get_collider()
		if collider is Player and Globals.player_vulnerable:
			Globals.health -=20
	

	


func _process(delta):
	progress_ratio += 0.025 * delta

	var current_rotation = $Turret.rotation
	var target_rotation: float

	if player_near:
		$Turret.look_at(Globals.player_position)
		target_rotation = $Turret.rotation
	else:
		target_rotation = 0.0 
	var rotation_speed = 1.5
	$Turret.rotation = lerp_angle(current_rotation, target_rotation, rotation_speed * delta)

func _on_notice_area_body_entered(_body):
	player_near = true
	$AnimationPlayer.play("laser_load")


func _on_notice_area_body_exited(_body):
	player_near = false
	
