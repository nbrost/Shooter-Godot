extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass




func _on_gate_player_entered_gate(_body):
	print("player entered gate")
	


func _on_player_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	grenade.z_index = $Player.z_index -1
	$Projectiles.add_child(grenade)


func _on_player_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.direction = direction
	laser.look_at(direction)
	laser.position = pos
	laser.z_index = $Player.z_index -1
	$Projectiles.add_child(laser)
