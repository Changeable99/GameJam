extends Node3D

var progress := 0
var target_progress := 50   # Wie oft muss gedrückt werden?
var last_key := ""          # Damit A und D abwechselnd gedrückt werden müssen

func _input(event):
	if event.is_action_pressed("Input_A"):
		if last_key != "a":
			progress += 1
			last_key = "a"
			print("A gedrückt! Fortschritt: ", progress)
	elif event.is_action_pressed("Input_D"):
		if last_key != "d":
			progress += 1
			last_key = "d"
			print("D gedrückt! Fortschritt: ", progress)
	if progress >= target_progress:
		print("Minispiel gewonnen!")
		# Hier kannst du z.B. ein Signal senden oder das Minispiel beenden
#wenn aktiv, dann player movment stoppen
#das es endet wenn ziel erreicht
#wenn ziel erreicht, bar füllen/ui dies das
#ich höre auf "E" von Player, dann start von minispiel
