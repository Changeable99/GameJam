extends Button

func _process(delta):
	if Input.is_action_pressed("Interact_F"):
		self.modulate = Color(1, 1, 0.8)  # Gelblich leuchten
	elif Input.is_action_just_released("Interact_F"):
		self.modulate = Color(1, 1, 1)  # Originalfarbe zurücksetzen
