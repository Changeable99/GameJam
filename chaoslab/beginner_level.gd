extends Node3D

@onready var gridMap : GridMap = $GridMap
@onready var newStationSpawnTimer : Timer = $NewStationSpawnTimer

var spawnableCells : Array = [Vector2(-5,5), Vector2(3,5), Vector2(5,2), 
							  Vector2(5,0), Vector2(5,-3), Vector2(4,-6), 
							  Vector2(1,-6), Vector2(-1,-6), Vector2(-6,-4), 
							  Vector2(-6,-1), Vector2(-4,0), Vector2(-1,0)]

@export var spawnableStations : Array[PackedScene]
@export var speedupSpawnFactor : float = 0.95
@export var timeTillNextSpawn : float = 10
var lastCellSpawned : Vector2 = Vector2(99, 99)

func _ready() -> void:
	randomize()
	newStationSpawnTimer.wait_time = timeTillNextSpawn
	newStationSpawnTimer.start()

# to identify cells that can spawn stations
func _input(event):
	return
	if event is InputEventMouseButton and event.pressed:
		var camera = get_viewport().get_camera_3d()  # Kamera abrufen
		var rayOrigin = camera.project_ray_origin(event.position)  # Mausposition erfassen
		var rayDirection = camera.project_ray_normal(event.position) * 100  # Strahl verlängern

		var spaceState = get_world_3d().direct_space_state
		var rayResult = spaceState.intersect_ray(PhysicsRayQueryParameters3D.create(rayOrigin, rayOrigin + rayDirection))

		if rayResult:
			var worldPosition = rayResult.position  # Getroffene Position
			var cellCoords = gridMap.local_to_map(worldPosition) # In Zellkoordinaten umwandeln
			var cellCoords2D = Vector2(cellCoords.x, cellCoords.z)  # Nur X und Z übernehmen

			print("Getroffene Zelle: ", cellCoords2D)


func _on_new_station_timer_timeout() -> void:
	# calculate new spawn timer
	var randomDelay = randf_range(timeTillNextSpawn * 0.9, timeTillNextSpawn * 1.1)
	#print(randomDelay)
	timeTillNextSpawn *= speedupSpawnFactor
	newStationSpawnTimer.wait_time = timeTillNextSpawn
	newStationSpawnTimer.start()
	
	# pick random cell, random station and spawn it
	var viableRandomCellFound : bool = false
	var randomCell : Vector2
	while !viableRandomCellFound:
		randomCell = spawnableCells[randi() % spawnableCells.size()]
		if randomCell != lastCellSpawned:
			lastCellSpawned = randomCell
			viableRandomCellFound = true
	#print("randomCell: " + str(randomCell))
	var worldPosRandomCell = gridMap.map_to_local(Vector3i(randomCell.x, 1, randomCell.y,))
	#print("worldPosRandomCell: " + str(worldPosRandomCell))
	#gridMap.set_cell_item(Vector3i(randomCell.x, 0, randomCell.y), -1)
	
	var randomStation : PackedScene = spawnableStations[randi() % spawnableStations.size()]
	#print("randomStation: " + randomStation.name)
	
	var newStation = randomStation.instantiate()
	add_child(newStation)
	newStation.global_transform.origin = worldPosRandomCell
