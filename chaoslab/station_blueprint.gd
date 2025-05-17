extends Node3D

@onready var interactionLabel : Label3D = $InteractionLabel
@onready var timeToSolveTimer : Timer = $TimeToSolveTimer
@onready var chaosTickTimer : Timer = $ChaosTickTimer
@onready var timerBar : ProgressBar = $TimerBar

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
	timerBar.modulate = Color.YELLOW


func _process(delta: float) -> void:
	# manage Timer
	if !timeToSolveTimer.is_stopped():
		if !halfTimeLeft:
			halfTimeLeft = timeToSolveTimer.time_left < (timeToSolveTimer.wait_time / 2)
		
			if halfTimeLeft:
				print("half time reached")
	
		# manage timer bar
		var ratio = clamp(timeToSolveTimer.time_left / timeToSolveTimer.wait_time, 0, 1)
		timerBar.value = ratio * 100

		if ratio < 0.5 && timerBar.modulate == Color.YELLOW:
			timerBar.modulate = Color.RED
			
		# manage chaos increase at half time
		if halfTimeLeft:
			chaosChangePerSec = lerp(maxChaosChangePerSec, minChaosChangePerSec, timeToSolveTimer.time_left / (timeToSolveTimer.wait_time /2))
			if chaosTickTimer.is_stopped():
				chaosTickTimer.start()
	else:
		pass
		#print("timer stopped")
	
	# manage interaction
	if isInteractable && Input.is_action_just_pressed("Interact_E") && Global.gameState == Global.GameState.DEFAULT:
		trigger_station_minigame()
	
func _on_interaction_area_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		print("Player entered interaction area of object: " + name)
		interactionLabel.visible = true
		isInteractable = true


func _on_interaction_area_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		print("Player left  interaction area of object: " + name)
		interactionLabel.visible = false
		isInteractable = false


func trigger_station_minigame() -> void:
	print("Station event triggered")
	interactionLabel.visible = false
	isInteractable = false
	timeToSolveTimer.stop()
	Global.gameState = Global.GameState.MINIGAME


func minigame_finished(completed : bool) -> void:
	if completed:
		print("Minigame completed!")
		Global.change_chaos(-chaosChangeByFinish)
	else:
		print("Minigame failed!")
		Global.change_chaos(chaosChangeByFinish)
	
	Global.gameState = Global.GameState.DEFAULT
	queue_free()


func _on_chaos_tick_timer_timeout() -> void:
	Global._change_chaos(chaosChangePerSec)
