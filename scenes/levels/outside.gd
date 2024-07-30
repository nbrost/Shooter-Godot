extends LevelParent

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")

func _on_house_body_entered(_body):
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 2)


func _on_house_body_exited(_body):
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 2)
