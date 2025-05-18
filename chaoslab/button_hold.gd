extends "res://station_blueprint.gd"

@onready var holdTimer := Timer.new()

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
	super._ready()
	holdDurationGoal = randf_range(2.0, 5.0)
	minigameDuration = holdDurationGoal + 2.0
	goalPercentageMin = randf_range(0.1, 0.8)
	goalPercentageMax = goalPercentageMin + randf_range(0.1, 0.25)
	if goalPercentageMax > 1.0:
		goalPercentageMax = 1.0
	goalHoldTimeMin = goalPercentageMin * holdDurationGoal
	goalHoldTimeMax = goalPercentageMax * holdDurationGoal
	
	print("hold duration goal: " + str(holdDurationGoal) + " secs")
	
	add_child(holdTimer)
	holdTimer.wait_time = 0.01
	holdTimer.one_shot = false
	holdTimer.timeout.connect(_on_hold_tick)

func _on_hold_tick() -> void:
	holdTime += holdTimer.wait_time
	#TODO: Progressbar

func _input(event: InputEvent) -> void:
	if minigameIsActive:
		if event.is_action_pressed("Interact_F"):
			if !isHolding:
				isHolding = true
				holdTime = 0.0
		elif event.is_action_released("Interact_F") and isHolding:
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
