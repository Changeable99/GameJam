extends "res://station_blueprint.gd"

var progress := 0
var targetProgress := 25   # Wie oft muss gedrückt werden?
var lastKey := ""          # Damit A und D abwechselnd gedrückt werden müssen
var minigameIsActive : bool = false

@onready var buttonSmashUI = preload("res://button_smah_ui.tscn")
var ui_instance

func _ready() -> void:
	super._ready()
	minigameDuration = 4

func trigger_station_minigame():
	super.trigger_station_minigame()
	minigameIsActive = true
	ui_instance = buttonSmashUI.instantiate()
	var canvas = get_tree().current_scene.get_node("HUD/CanvasLayer")
	canvas.add_child(ui_instance)
	
func _input(event):
	if not minigameIsActive:
		return
		
	if event.is_action_pressed("Input_A"):
		if lastKey != "A":
			progress += 1
			lastKey = "A"
			print("A gedrückt! Fortschritt: ", progress)
	elif event.is_action_pressed("Input_D"):
		if lastKey != "D":
			progress += 1
			lastKey = "D"
			print("D gedrückt! Fortschritt: ", progress)
	
	# minigame completed
	if progress >= targetProgress:
		ui_instance.queue_free()
		super.minigame_finished(true)

func _on_minigame_duration_timer_timeout() -> void:
	super._on_minigame_duration_timer_timeout()
	if ui_instance:
		ui_instance.queue_free()
		
