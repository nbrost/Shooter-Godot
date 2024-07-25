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
	item.position = pos
	$Items.add_child(item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_player_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	grenade.z_index = $Ground.z_index + 1
	$Projectiles.add_child(grenade)
	$UI.update_grenade_text()


func _on_player_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.direction = direction
	laser.look_at(direction)
	laser.position = pos
	$Projectiles.add_child(laser)
	$UI.update_laser_text()


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 2)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 2)


func _on_player_update_stats():
	$UI.update_grenade_text()
	$UI.update_laser_text()
