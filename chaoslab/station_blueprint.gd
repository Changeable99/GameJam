extends Node3D

@onready var interactionLabel : Label3D = $InteractionLabel
@onready var timeToSolveTimer : Timer = $TimeToSolveTimer
@onready var chaosTickTimer : Timer = $ChaosTickTimer
@onready var minigameDurationTimer : Timer = $MinigameDurationTimer
@onready var progressBar : ProgressBar = $SubViewport/TimerBar
@onready var progressBarMesh : MeshInstance3D = $ProgressBarMesh

var styleBoxFill : StyleBoxFlat
var isInteractable : bool = false

@export var timeToSolve : float = 10.0
var halfTimeLeft : bool = false
@export var minigameDuration : float = 5.0

@export var chaosChangeByFinish : int = 50
var chaosChangePerSec : int = 10
var minChaosChangePerSec : int = 10
var maxChaosChangePerSec : int = 50


func _ready() -> void:
	interactionLabel.visible = false
	
	timeToSolveTimer.wait_time = timeToSolve
	timeToSolveTimer.start()
	
	minigameDurationTimer.wait_time = minigameDuration
	
	# progress bar initiatlization
	styleBoxFill = progressBar.get_theme_stylebox("fill").duplicate()  # Neue Instanz
	styleBoxFill.bg_color = Color.YELLOW  # Farbe setzen
	progressBar.add_theme_stylebox_override("fill", styleBoxFill)  # Override für ProgressBar


func _process(delta: float) -> void:
	# manage Timer
	if !timeToSolveTimer.is_stopped():
		if !halfTimeLeft:
			halfTimeLeft = timeToSolveTimer.time_left < (timeToSolveTimer.wait_time / 2)
	
		# manage timer bar
		var ratio = clamp(timeToSolveTimer.time_left / timeToSolveTimer.wait_time, 0, 1)
		progressBar.value = ratio * 100

		if ratio < 0.5 && styleBoxFill.bg_color == Color.YELLOW:
			var styleBoxFill : StyleBoxFlat = progressBar.get_theme_stylebox("fill")
			styleBoxFill.bg_color = Color.RED
			progressBar.add_theme_color_override("font_color", Color(Color.GHOST_WHITE))
			
		# manage chaos increase at half time
		if halfTimeLeft:
			chaosChangePerSec = lerp(maxChaosChangePerSec, minChaosChangePerSec, timeToSolveTimer.time_left / (timeToSolveTimer.wait_time /2))
			if chaosTickTimer.is_stopped():
				chaosTickTimer.start()
	
	# manage interaction
	if isInteractable && Input.is_action_just_pressed("Interact_E") && Global.gameState == Global.GameState.DEFAULT:
		trigger_station_minigame()
	
func _on_interaction_area_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		#print("Player entered interaction area of object: " + name)
		interactionLabel.visible = true
		isInteractable = true

func _on_interaction_area_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		#print("Player left  interaction area of object: " + name)
		interactionLabel.visible = false
		isInteractable = false

func trigger_station_minigame() -> void:
	interactionLabel.visible = false
	isInteractable = false
	progressBar.visible = false
	progressBarMesh.visible = false
	timeToSolveTimer.stop()
	minigameDurationTimer.start()
	Global.gameState = Global.GameState.MINIGAME

func minigame_finished(completed : bool) -> void:
	if completed:
		Global._change_chaos(-chaosChangeByFinish)
	else:
		Global._change_chaos(chaosChangeByFinish)
	
	Global.gameState = Global.GameState.DEFAULT
	queue_free()

func _on_chaos_tick_timer_timeout() -> void:
	Global._change_chaos(chaosChangePerSec)

func _on_time_to_solve_timer_timeout() -> void:
	minigame_finished(false)
	
func _on_minigame_duration_timer_timeout() -> void:
	minigame_finished(false)
