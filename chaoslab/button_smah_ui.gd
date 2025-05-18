extends Control

func _ready() -> void:
	$VBoxContainer/HBoxContainer/A.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$VBoxContainer/HBoxContainer/D.mouse_filter = Control.MOUSE_FILTER_IGNORE
