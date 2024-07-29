extends StaticBody2D
class_name ItemContainerParent 


@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)
signal open(position, direction)
var opened: bool = false


func hit():
	if !opened:
		opened = true
		$LidSprite.hide()
		for i in range(5):
			var pos = $SpawnPositions2.get_child(randi()%$SpawnPositions2.get_child_count()).global_position
			open.emit(pos, current_direction)
