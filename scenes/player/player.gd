extends Node2D

var pos: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_vector("left", "right","up","down")
	position = position + direction * delta * 500
	
	if Input.is_action_pressed("primary action"):
		print("shootin")
	
	if Input.is_action_pressed("secondary action"):
		print("grenade out")
	if Input.is_action_pressed("left"):
		var rot = delta * 5
		$"..".RotatePlayer(rot)
	if Input.is_action_pressed("right"):
		var rot = delta * -5
		$"..".RotatePlayer(rot)
