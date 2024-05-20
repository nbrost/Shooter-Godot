extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Logo.rotation_degrees=90


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Logo.position.x +=100 * delta
	
	$Logo.rotation_degrees += 500 * delta
	if $Logo.position.x > 1000:
		$Logo.position.x = 0
	Input


func RotatePlayer(amount):
	$Player.rotation_degrees += amount
