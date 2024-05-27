extends Node2D

var laser_scene: PackedScene = preload("res://scenes/objects/laser.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass




func _on_gate_player_entered_gate(_body):
	print("player entered gate")
	


func _on_player_grenade():
	
	print("grenades yo")


func _on_player_laser(pos):
	var laser = laser_scene.instantiate()
	laser.position = pos
	print(pos)
	add_child(laser)
	print("laser yo")
