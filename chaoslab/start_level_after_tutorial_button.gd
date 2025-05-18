extends Button

func _pressed():		
	get_tree().paused = false
	get_parent().get_parent().hide()
