extends Control

@onready var label : Label = $VBoxContainer/Label
@onready var holdProgressBar : ProgressBar = $VBoxContainer/VBoxContainer/Panel/holdProgressBar
@onready var markerGoal = $VBoxContainer/VBoxContainer/Panel/Goal
@onready var markerMinGoal = $VBoxContainer/VBoxContainer/Panel/minGoal
@onready var markerMaxGoal = $VBoxContainer/VBoxContainer/Panel/maxGoal

var holdDurationGoal : float
var holdDurationGoalPercentage : float
var minHoldDurationGoal : float
var maxHoldDurationGoal : float

func _ready() -> void:
	holdDurationGoal = round(holdDurationGoal * 100.0) / 100.0
	label.text = "Hold 'F' " + str(holdDurationGoal) + " secs."
	
	position_markers()

func update_hold_progress(currentHoldPercentage: float) -> void:
	holdProgressBar.value = currentHoldPercentage
	
func position_markers():
	print("Min: " + str(minHoldDurationGoal) + " Max: " + str(maxHoldDurationGoal) + " Goal: " + str(holdDurationGoalPercentage))
	
	var barWidth = holdProgressBar.get_size().x
	var barPos = holdProgressBar.position

	# Berechne X-Positionen auf Basis der Prozentwerte
	markerGoal.position.x = barPos.x + barWidth * holdDurationGoalPercentage
	markerMinGoal.position.x = barPos.x + barWidth * minHoldDurationGoal
	markerMaxGoal.position.x = barPos.x + barWidth * maxHoldDurationGoal

	# Optional: Höhe und Y-Ausrichtung angleichen
	var barHeight = holdProgressBar.get_size().y
	markerGoal.position.y = barPos.y
	markerMinGoal.position.y = barPos.y
	markerMaxGoal.position.y = barPos.y

	markerGoal.size.y = barHeight
	markerMinGoal.size.y = barHeight
	markerMaxGoal.size.y = barHeight
