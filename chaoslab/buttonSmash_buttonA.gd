extends Button

func _process(delta):
	if Input.is_action_pressed("Input_A"):
		self.modulate = Color(1, 1, 0.8)  # Gelblich leuchten
	elif Input.is_action_just_released("Input_A"):
		self.modulate = Color(1, 1, 1)  # Originalfarbe zurücksetzen
