extends Button

func _pressed() -> void:
	$"..".visible = false
	$"../../Scoreboard_box".visible = true
