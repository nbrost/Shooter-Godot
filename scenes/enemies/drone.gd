extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Vector2.RIGHT
	velocity = direction * 100
	move_and_slide()
 
func hit():
	print("I got hit")
