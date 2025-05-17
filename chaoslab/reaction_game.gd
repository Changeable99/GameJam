extends "res://station_blueprint.gd"

var minigameIsActive : bool = false  


func trigger_station_minigame():
	super.trigger_station_minigame()
	minigameIsActive = true
	print("klappt")
	
func _input(event):
	if not minigameIsActive:
		return
	else:	
		randomize()
		var wait_time = randf_range (0.1, 2.0)
		print(wait_time) 
	
		#zu früh gedrückt
		var early_fail = false
		var timer = get_tree().create_timer(wait_time)
		while timer.time_left > 0:
			await get_tree().process_frame
			if Input.is_key_pressed(KEY_W):
				early_fail = true
				print("zu früh du opfer")
				minigame_finished(false)
				return
		
	
		print("Press W")
		var w_pressed = false
		var press_timer = get_tree().create_timer(2.0)
		while press_timer.time_left > 0:
			await get_tree().process_frame
			if Input.is_key_pressed(KEY_W):
				w_pressed = true
				break
		if w_pressed:
			print("Glück gehabt du lelek")
			minigame_finished(true)
			return
		else:
			print("zu langsam zu opfer")
			minigame_finished(false)
			return
