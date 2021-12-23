extends Node2D


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == 1:
				if Rect2(position, CardManager.card_size).has_point(get_global_mouse_position()):
					emit_signal("player_clicked_deck")
