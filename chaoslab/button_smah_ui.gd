extends Control

func _ready() -> void:
	$VBoxContainer/HBoxContainer/A.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$VBoxContainer/HBoxContainer/D.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Input_A"):
		$VBoxContainer/HBoxContainer/A.set_pressed_no_signal(true)
		await get_tree().create_timer(0.1).timeout
		$VBoxContainer/HBoxContainer/A.set_pressed_no_signal(false)
	elif event.is_action_pressed("Input_D"):
		$VBoxContainer/HBoxContainer/D.set_pressed_no_signal(true)
		await get_tree().create_timer(0.1).timeout
		$VBoxContainer/HBoxContainer/D.set_pressed_no_signal(false)
