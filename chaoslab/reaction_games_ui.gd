extends Control

func set_keys(key1, key2, key3, key4) -> void:
	$VBoxContainer/HBoxContainer/Key_1.text = key1
	$VBoxContainer/HBoxContainer/Key_2.text = key2
	$VBoxContainer/HBoxContainer/Key_3.text = key3
	$VBoxContainer/HBoxContainer/Key_4.text = key4

func highlight_key(keyIndex) -> void:
	$VBoxContainer/HBoxContainer.get_child(keyIndex).modulate = Color(1,1,0.8)
