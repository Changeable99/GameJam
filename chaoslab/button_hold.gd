extends "res://station_blueprint.gd"

var holdDurationGoal : float
var minigameIsActive : bool = false

var holdTime : float = 0.0
var isHolding : bool = false
var goalPercentageMin : float
var goalPercentageMax : float
var goalPercentage : float
var goalHoldTimeMin : float
var goalHoldTimeMax : float

func _ready() -> void:
	holdDurationGoal = randf_range(2.0, 5.0)
	minigameDuration = holdDurationGoal + 2.0
	goalPercentageMin = randf_range(0.1, 0.8)
	goalPercentageMax = goalPercentageMin + randf_range(0.1, 0.25)
	if goalPercentageMax > 1.0:
		goalPercentageMax = 1.0
	goalHoldTimeMin = goalPercentageMin * holdDurationGoal
	goalHoldTimeMax = goalPercentageMax * holdDurationGoal
	
	print("hold duration goal: " + str(holdDurationGoal) + " secs")
	
func _process(delta: float) -> void:
	super._process(delta)
	if minigameIsActive:
		if Input.is_action_pressed("Interact_F"):
			if !isHolding:
				isHolding = true
				holdTime = 0.0
			holdTime += delta
		else:
			if isHolding:
				isHolding = false
				on_key_released()

func trigger_station_minigame():
	super.trigger_station_minigame()
	minigameIsActive = true
	#ui_instance = buttonSmashUI.instantiate()
	#var canvas = get_tree().current_scene.get_node("HUD/CanvasLayer")
	#canvas.add_child(ui_instance)
	
func on_key_released() -> void:
	goalPercentage = holdTime / holdDurationGoal
	print("min: " + str(goalHoldTimeMin) + " max: " + str(goalHoldTimeMax) + " result: " + str(holdTime))
	
	if goalPercentage > goalPercentageMin && goalPercentage < goalPercentageMax:
		super.minigame_finished(true)
	else:
		super.minigame_finished(false)
