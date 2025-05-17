extends Node3D

@onready var interactionLabel : Label3D = $InteractionLabel
@onready var timeToSolveTimer : Timer = $TimeToSolveTimer

var isInteractable : bool = false

@export var timeToSolve : float = 10.0
var halfTimeLeft : bool = false

@export var chaosChangeByFinish : float = 50.0
var chaosChangePerSec : float = 10.0
var maxChaosChangePerSec : float = 50.0 


func _ready() -> void:
	interactionLabel.visible = false
	timeToSolveTimer.wait_time = timeToSolve
	timeToSolveTimer.start()


func _process(delta: float) -> void:
	if !halfTimeLeft:
		halfTimeLeft = timeToSolveTimer.time_left < (timeToSolveTimer.wait_time / 2)
		
		if halfTimeLeft:
			print("half time reached")
	
	# TODO: Abfrage auf Global.StateMachine
	if isInteractable && Input.is_action_just_pressed("Interact_E"):
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


func minigame_finished(completed : bool) -> void:
	if completed:
		print("Minigame completed!")
		#TODO: Global.change_chaos(chaosChange)
	else:
		print("Minigame failed!")
		#TODO: Global.change_chaos(-chaosChange)
	queue_free()
