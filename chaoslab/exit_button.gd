extends Button

func _pressed() -> void:
	$"../../MainMenu_box".visible = true
	$"..".visible = false
