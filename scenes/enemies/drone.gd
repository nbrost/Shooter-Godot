extends CharacterBody2D

var active: bool = false
var vulnerable: bool = true
var speed: int = 400
var health: int = 50

func _ready():
	$Explosion.visible = false

func _process(_delta):
	var direction = (Globals.player_position - position).normalized()
	if active:
		look_at(Globals.player_position)
		velocity = direction * speed
		move_and_slide()
 
func hit():
	if vulnerable:
		vulnerable = false
		$HitTimer.start()
		health -= 10
	if health <= 0:
		$AnimationPlayer.play("explosion")


func _on_notice_area_body_entered(_body):
	active = true


func _on_hit_timer_timeout():
	vulnerable = true
