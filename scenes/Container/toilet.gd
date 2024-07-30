extends ItemContainerParent

func hit():
	if !opened:
		opened = true
		$LidSprite.hide()
		var pos = $SpawnPositions2.get_child(randi()%$SpawnPositions2.get_child_count()).global_position
		open.emit(pos, current_direction)
