extends "res://station_blueprint.gd"

@onready var buttonHoldUI = preload("res://button_hold_ui.tscn")

var uiInstance

var holdDurationGoal : float
var minigameIsActive : bool = false

var holdTime : float = 0.0
var isHolding : bool = false
var goalPercentageMin : float
var goalPercentageMax : float
var goalPercentage : float
var holdDurationGoalPercentage : float
var goalHoldTimeMin : float
var goalHoldTimeMax : float

func _ready() -> void:
	super._ready()
	randomize()
	holdDurationGoal = randf_range(1.0, 5.0)
	holdDurationGoalPercentage = (holdDurationGoal - 1.0) / (5.0 - 1.0)
	minigameDuration = 10.0
	goalPercentageMin = holdDurationGoalPercentage - randf_range(0.05, 0.15)
	goalPercentageMax = goalPercentageMin + randf_range(0.1, 0.2)
	if goalPercentageMax > 1.0:
		goalPercentageMax = 1.0
	if goalPercentageMin < 0.0:
		goalPercentage = 0.0
	goalHoldTimeMin = goalPercentageMin * holdDurationGoal
	goalHoldTimeMax = goalPercentageMax * holdDurationGoal

func _process(delta: float) -> void:
	super._process(delta)
	if minigameIsActive:
		if Input.is_action_pressed("Interact_F"):
			if !isHolding:
				isHolding = true
				holdTime = 0.0
			holdTime += delta
			goalPercentage = holdTime / holdDurationGoal
			uiInstance.update_hold_progress(goalPercentage)
		if Input.is_action_just_released("Interact_F"):
			isHolding = false
			on_key_released()

func trigger_station_minigame():
	super.trigger_station_minigame()
	minigameIsActive = true
	uiInstance = buttonHoldUI.instantiate()
	uiInstance.holdDurationGoal = holdDurationGoal
	uiInstance.holdDurationGoalPercentage = holdDurationGoalPercentage
	uiInstance.minHoldDurationGoal = goalPercentageMin
	uiInstance.maxHoldDurationGoal = goalPercentageMax
	var canvas = get_tree().current_scene.get_node("HUD/CanvasLayer")
	canvas.add_child(uiInstance)
	
func on_key_released() -> void:
	if goalPercentage > goalPercentageMin && goalPercentage < goalPercentageMax:
		super.minigame_finished(true)
	else:
		super.minigame_finished(false)
		
	if uiInstance:
		uiInstance.queue_free()

func _on_minigame_duration_timer_timeout() -> void:
	super._on_minigame_duration_timer_timeout()
	if uiInstance:
		uiInstance.queue_free()
