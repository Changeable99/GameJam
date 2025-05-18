extends Label

func _get_score() -> void:
	text = Global.displayTime

func _on_gameover_window_visibility_changed() -> void:
	_get_score()
