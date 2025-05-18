extends "res://station_blueprint.gd"

var minigameIsActive : bool = false
var possibleKeys = ["W","A","S","D"]
var keysToPress = []
var currentKey = 0

@onready var reactionGameUI = preload("res://reaction_games_ui.tscn")
var ui_instance

func _ready() -> void:
	super._ready()
	minigameDuration = 3

func trigger_station_minigame():
	super.trigger_station_minigame()
	minigameIsActive = true
	ui_instance = reactionGameUI.instantiate()
	var canvas = get_tree().current_scene.get_node("HUD/CanvasLayer")
	canvas.add_child(ui_instance)
	
	#Define keys
	for i in range(4):
		var random_number = randi() % 4
		keysToPress.append(possibleKeys.get(random_number))
	ui_instance.set_keys(keysToPress.get(0), keysToPress.get(1), keysToPress.get(2), keysToPress.get(3))
	currentKey = 0

func _input(event):
	if not minigameIsActive:
		return
	else:
		if event.is_action_pressed("Input_W"):
			if keysToPress.get(0) == "W":
				keysToPress.remove_at(0)
				ui_instance.highlight_key(currentKey)
				currentKey += 1
			else:
				super.minigame_finished(false)
				ui_instance.queue_free()
		elif event.is_action_pressed("Input_A"):
			if keysToPress.get(0) == "A":
				keysToPress.remove_at(0)
				ui_instance.highlight_key(currentKey)
				currentKey += 1
			else:
				super.minigame_finished(false)
				ui_instance.queue_free()
		elif event.is_action_pressed("Input_S"):
			if keysToPress.get(0) == "S":
				keysToPress.remove_at(0)
				ui_instance.highlight_key(currentKey)
				currentKey += 1
			else:
				super.minigame_finished(false)
				ui_instance.queue_free()
		elif event.is_action_pressed("Input_D"):
			if keysToPress.get(0) == "D":
				keysToPress.remove_at(0)
				ui_instance.highlight_key(currentKey)
				currentKey += 1
			else:
				super.minigame_finished(false)
				ui_instance.queue_free()
				
		if keysToPress.is_empty():
			super.minigame_finished(true)
			ui_instance.queue_free()
