extends Node3D

@onready var interactionLabel : Label3D = $InteractionLabel

var isInteractable : bool = false

func _ready() -> void:
	interactionLabel.visible = false

func _process(delta: float) -> void:
	# Abfrage auf Global.StateMachine
	if isInteractable && Input.is_action_just_pressed("Interact_E"):
		trigger_station_event()

func _on_interaction_area_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		print("Player entered interaction area of object: " + name)
		interactionLabel.visible = true
		isInteractable = true

func trigger_station_event() -> void:
	print("Station event triggered")
	interactionLabel.visible = false
	isInteractable = false
	#spawn minigame

func _on_interaction_area_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		print("Player left  interaction area of object: " + name)
		interactionLabel.visible = false
		isInteractable = false
		
