extends Button

func _pressed() -> void:
	$"..".visible = false
	$"../../Scoreboard".visible = true
