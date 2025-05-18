extends Node3D

@onready var audioStreamPlayer : AudioStreamPlayer = $TitlescreenMusic

func _on_audio_stream_player_finished() -> void:
	audioStreamPlayer.play()
