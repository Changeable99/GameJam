extends Control

@onready var label : Label = $VBoxContainer/Label
var holdDurationGoal : float

func _ready() -> void:
	holdDurationGoal = round(holdDurationGoal * 100.0) / 100.0
	label.text = "Hold 'F' " + str(holdDurationGoal) + " secs."
