extends CharacterBody2D

var pos: Vector2 = Vector2.ZERO
var can_laser: bool = true
var can_grenade: bool = true
var laser_ammo: int = 10
var grenade_ammo: int = 3

signal laser(pos)
signal grenade

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("left", "right","up","down")
	velocity = direction * 500
	move_and_slide()
	
	if Input.is_action_just_pressed("primary action") and can_laser and laser_ammo > 0:
		var possible_lasers = $LaserStartPosititions.get_children()
		var selected_laser = possible_lasers[randi() % possible_lasers.size()]
		print('shoot laser')
		print(selected_laser)
		laser.emit($".".global_position + selected_laser.position)
		laser_ammo += -1
		can_laser = false
		$LaserTimer.start()
		
	if Input.is_action_just_pressed("secondary action") and can_grenade and grenade_ammo > 0:
		print('throw grenade')
		grenade_ammo += -1
		grenade.emit()
		can_grenade = false
		$GrenadeTimer.start()
		


func _on_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
