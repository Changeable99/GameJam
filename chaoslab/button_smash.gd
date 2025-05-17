extends "res://station_blueprint.gd"

var progress := 0
var targetProgress := 50   # Wie oft muss gedrückt werden?
var lastKey := ""          # Damit A und D abwechselnd gedrückt werden müssen
var minigameIsActive : bool = false

func trigger_station_event():
	super.trigger_station_event()
	minigameIsActive = true
	print("klappt")
	
	
func _input(event):
	if not minigameIsActive:
		return
		
	if event.is_action_pressed("Input_A"):
		if lastKey != "a":
			progress += 1
			lastKey = "a"
			print("A gedrückt! Fortschritt: ", progress)
	elif event.is_action_pressed("Input_D"):
		if lastKey != "d":
			progress += 1
			lastKey = "d"
			print("D gedrückt! Fortschritt: ", progress)
	if progress >= targetProgress:
		print("Minispiel gewonnen!")
		# Hier kannst du z.B. ein Signal senden oder das Minispiel beenden
#wenn aktiv, dann player movment stoppen
#das es endet wenn ziel erreicht
#wenn ziel erreicht, bar füllen/ui dies das
#ich höre auf "E" von Player, dann start von minispiel
