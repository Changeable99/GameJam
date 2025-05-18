extends Label

func _process(delta: float) -> void:
		var score = Global.highScore
		if score:
			var minutes = int(score) / 60
			var seconds = int(score) % 60
			text = "HIGHSCORE: %02d:%02d" % [minutes, seconds]
