extends CharacterBody3D

@export var movementSpeed: float = 10
var inputVector: Vector2

func _physics_process(delta: float) -> void:

	inputVector = Vector2.ZERO
	if Input.is_action_pressed("Input_A"):
		inputVector.y -= 1
	if Input.is_action_pressed("Input_D"):
		inputVector.y += 1
	if Input.is_action_pressed("Input_W"):
		inputVector.x += 1
	if Input.is_action_pressed("Input_S"):
		inputVector.x -= 1
		
	inputVector = inputVector.normalized()
	velocity = Vector3(inputVector.x,0,inputVector.y)*movementSpeed
	move_and_slide()
