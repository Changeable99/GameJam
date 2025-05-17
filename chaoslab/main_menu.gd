extends Node3D

@onready var audioStreamPlayer : AudioStreamPlayer3D = $TitlescreenMusic

func _on_audio_stream_player_3d_finished() -> void:
	audioStreamPlayer.play()
