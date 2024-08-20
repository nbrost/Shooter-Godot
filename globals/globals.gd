extends Node

signal stat_change

var laser_amount: int = 20:
	get:
		return laser_amount
	set(value):
		if value > 60:
			value = 60
		if value < 0:
			value = 0
		laser_amount = value
		stat_change.emit()
var grenade_amount: int = 5:
	get:
		return grenade_amount
	set(value):
		if value > 10:
			value = 10
		if value < 0:
			value = 0
		grenade_amount = value
		stat_change.emit()
var health: int = 60:
	get:
		return health
	set(value):
		if value > 100:
			value = 100
		if value < 0:
			value = 0
		health = value
		stat_change.emit()
		
var player_position: Vector2

