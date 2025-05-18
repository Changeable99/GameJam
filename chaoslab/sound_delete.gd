extends Node3D

@export var lifetime: float = 3.0  # Lebensdauer in Sekunden

func _ready():
	die_after_time(lifetime)

func die_after_time(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	queue_free()
