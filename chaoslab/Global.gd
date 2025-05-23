extends Node

var startMoney: int = 1000
var startChaos: int = 500
var startTime = 0

var currentMoney: int
var moneyFactor = 0.25
var currentChaos: int
var currentTime = 0
var displayTime: String
var gameState: GameState = GameState.DEFAULT
var scoreTime
var highScore

var game_started = false
var gameOver = false

enum GameState {
	DEFAULT,
	MINIGAME,
	MENU
}

func start_game():
	currentChaos = startChaos
	currentMoney = startMoney
	currentTime = startTime
	game_started = true
	get_tree().paused = true

func _process(delta: float) -> void:
	if game_started:
		_calculate_time(delta)
		_calculate_income()
	
func _change_chaos(chaos: int) -> void:
	currentChaos += chaos
	#print("Chaos changed by: " + str(chaos))
	
func _change_money(money: int) -> void:
	currentMoney += money
	if currentMoney <= 0:
		currentMoney = 0
		_end_game()
	
func _set_money(money: int) -> void:
	currentMoney = money
	
func _calculate_time(delta) -> void:
	currentTime += delta
	var minutes = int(currentTime) / 60
	var seconds = int(currentTime) % 60
	displayTime = "%02d:%02d" % [minutes, seconds]
	
func _end_game():
	scoreTime = currentTime
	_set_money(0)
	gameOver = true
	
	if highScore:
		if scoreTime >  highScore:
			highScore = scoreTime
	else: highScore = scoreTime
	
	var gameOverWindow = get_tree().current_scene.get_node("HUD/CanvasLayer/GAMEOVERWindow")
	gameOverWindow.show()
	get_tree().paused = true
	game_started = false
	
func _calculate_income() -> void :
	var maxChaos = 500
	var income = 0
	var distance = abs(currentChaos - maxChaos) 
	
	if currentChaos >= 300 and currentChaos <= 600:
		income = (100 - (distance)) * moneyFactor
	else:
		income = -(distance - 100) * 0.2 * moneyFactor
	
	_change_money(income)
