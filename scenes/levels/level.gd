extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://items/item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("open", _on_container_opened)

func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.direction = direction
	item.position = pos
	$Items.call_deferred('add_child', item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_player_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	grenade.z_index = $Ground.z_index + 1
	$Projectiles.add_child(grenade)

func _on_player_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.direction = direction
	laser.look_at(direction)
	laser.position = pos
	$Projectiles.add_child(laser)
