extends CharacterBody2D

var pos: Vector2 = Vector2.ZERO
var can_laser: bool = true
var can_grenade: bool = true
var laser_ammo: int = 50
var grenade_ammo: int = 15

signal laser(posi,direction)
signal grenade(posi, direction)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# Input
	var player_direction = (get_global_mouse_position() - position).normalized()
	var barrel_position = get_barrel_position()
	var direction = Input.get_vector("left", "right","up","down")
	velocity = direction * 500
	move_and_slide()
	
	# Rotate
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("primary action") and can_laser and laser_ammo > 0:
		laser_ammo += -1
		laser.emit(barrel_position, player_direction)
		can_laser = false
		$LaserTimer.start()
		
	if Input.is_action_just_pressed("secondary action") and can_grenade and grenade_ammo > 0:		
		grenade_ammo += -1
		grenade.emit(barrel_position, player_direction)
		can_grenade = false
		$GrenadeTimer.start()
		

func get_barrel_position():
	var possible_lasers = $LaserStartPositions.get_children()
	var selected_laser = possible_lasers[randi() % possible_lasers.size()]
	var barrel_position = selected_laser.global_position
	return barrel_position


func _on_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
