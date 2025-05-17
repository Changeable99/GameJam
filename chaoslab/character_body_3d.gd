extends CharacterBody3D

@export var movementSpeed: float = 10
var inputVector: Vector2

func _physics_process(delta: float) -> void:
	if Global.gameState == Global.GameState.DEFAULT:
		inputVector = Vector2.ZERO
	
		if Input.is_action_pressed("Input_A"):
			inputVector.x -= 1
		if Input.is_action_pressed("Input_D"):
			inputVector.x += 1
		if Input.is_action_pressed("Input_W"):
			inputVector.y -= 1
		if Input.is_action_pressed("Input_S"):
			inputVector.y += 1
			
		inputVector = inputVector.normalized()
		velocity = Vector3(inputVector.x,0,inputVector.y)*movementSpeed
		var lookAtRotation: Vector3 = Vector3(-inputVector.x, 0, -inputVector.y)
		
		if lookAtRotation != Vector3.ZERO:
			look_at(global_transform.origin + lookAtRotation, Vector3.UP)
		
		move_and_slide()
